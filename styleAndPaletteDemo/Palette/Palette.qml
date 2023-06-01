import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import "qrc:/common"

Item {
    id: container
    property var selectColor: null     // 选择的某个颜色(不包含透明度)
    property real saturationVale: 1.0  // 饱和度(设置亮度 某种光谱色与白色混合的结果), 1.0表示饱和度最高, 0.0最接近白色
    property real drawRatio: 0.5       // 绘制比例(只有界面初始化时才会调用),0.1~1.0,值越大,效率越低,值越小,效率越高,但是会有锯齿

    signal colorChange(color c);       // 设置某个颜色的信号


    // 根据饱和度计算selectColor颜色
    function setColorFromSaturation() {
        var maxColor = Math.max(selectColor.r,selectColor.b,selectColor.g);

        // 饱和度越高越鲜明
        var color = Qt.rgba(selectColor.r + (maxColor - selectColor.r)*(1 - saturationVale),
                            selectColor.g + (maxColor - selectColor.g)*(1 - saturationVale),
                            selectColor.b + (maxColor - selectColor.b)*(1 - saturationVale),
                            1.0);
        colorChange(color);
    }


    // 根据画布位置获取颜色
    function setColorFromPanelPos(mouseX, mouseY) {
        var ar = panelCanvas.context.getImageData(mouseX, mouseY, 1, 1);

        selectColor = Qt.rgba(ar.data[0]/255, ar.data[1]/255, ar.data[2]/255, 1.0);
        setColorFromSaturation();
    }

    // 复位选中的位置
    function resetDot() {
        dot.pointX = -1
        saturationDot.pointY = 0
    }


    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        Rectangle {
            id: panel
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true

            border.color: Qt.rgba(Material.foreground.r, Material.foreground.g, Material.foreground.b, 0.25)
            color: "transparent"
            //  画布内容
            Item {
                id: panelContent
                anchors.fill: parent
                anchors.margins: 3

                Rectangle {
                    id: dot
                    property var pointX: -1
                    property var pointY: -1

                    x: dot.pointX - width/2
                    y: dot.pointY - height/2
                    width: 11
                    height: width
                    radius: width/2
                    border.width: 2
                    border.color: "#FFF"
                    color: "transparent"
                    z: 100
                    visible: pointX < 0 ? false : true


                }

                MouseArea {
                    anchors.fill: parent

                    onPositionChanged: {

                        dot.pointX = mouseX < 0 ? 0 : mouseX >width ? width : mouseX
                        dot.pointY = mouseY < 0 ? 0 : mouseY >height ? height : mouseY

                        setColorFromPanelPos(dot.pointX, dot.pointY)

                    }
                    onClicked: {
                        dot.pointX = mouseX
                        dot.pointY = mouseY

                        setColorFromPanelPos(dot.pointX, dot.pointY)

                    }
                }
            }

            Canvas {
                id: panelCanvas
                anchors.fill: panelContent
                parent: panelContent
                onPaint: {
                      var ctx = getContext("2d");

                      var itemH = height / 255 / drawRatio;  // 计算绘制的高度

                      if (itemH<1.0) {
                         itemH = 1.0
                      }
                      itemH = Math.ceil(itemH)
                      var itemLen = height /itemH;      // 计算需要绘制多少排数据



                      // 255,0,0 -> 255,255,0 -> 0,255,0 -> 0,255,255
                      // -> 0,0,255 -> 255,0,255 ->255,0,0

                      var stepColorBaseArr = [Qt.rgba(1,0,0,1),
                                              Qt.rgba(1,1,0,1),
                                              Qt.rgba(0,1,0,1),
                                              Qt.rgba(0,1,1,1),
                                              Qt.rgba(0,0,1,1),
                                              Qt.rgba(1,0,1,1),
                                              Qt.rgba(1,0,0,1)];

                      var stepColorArr = [Qt.rgba(1,0,0,1),
                                          Qt.rgba(1,1,0,1),
                                          Qt.rgba(0,1,0,1),
                                          Qt.rgba(0,1,1,1),
                                          Qt.rgba(0,0,1,1),
                                          Qt.rgba(1,0,1,1),
                                          Qt.rgba(1,0,0,1)];

                      var baseY = 0;
                      // 遍历绘制每排画布区域
                      for (var i = 0; i < itemLen; ++i) {
                          var linear = ctx.createLinearGradient(0,baseY,width,baseY);

                          var step = 1.0/7;

                          linear.addColorStop(0, stepColorArr[0]);
                          linear.addColorStop(step, stepColorArr[1]);
                          linear.addColorStop(step*2, stepColorArr[2]);
                          linear.addColorStop(step*3, stepColorArr[3]);
                          linear.addColorStop(step*4, stepColorArr[4]);
                          linear.addColorStop(step*5, stepColorArr[5]);
                          linear.addColorStop(1.0, stepColorArr[6]);

                          // Fill with gradient
                          ctx.fillStyle = linear;
                          ctx.fillRect(0,baseY,width,baseY+itemH);

                          var dark = 1 - i/(itemLen)

                          for (var j =0 ; j < stepColorArr.length; ++j) {
                              stepColorArr[j].r = stepColorBaseArr[j].r *dark;
                              stepColorArr[j].g = stepColorBaseArr[j].g *dark;
                              stepColorArr[j].b = stepColorBaseArr[j].b *dark;
                          }

                        //  console.log(i,baseY,baseY+itemH, dark,stepColorBaseArr[0].r, stepColorArr[0].r)
                          baseY += itemH;
                      }

                }
            }
        }

        // 饱和度画布, 设置亮度 某种光谱色与白色混合的结果
        Rectangle {
            id : saturationPanel
            Layout.fillHeight: true
            Layout.preferredWidth: 38
            radius: 3
            border.color: Qt.rgba(Material.foreground.r, Material.foreground.g, Material.foreground.b, 0.25)
            color: "transparent"

            //  画布内容
            Item {
                id: saturationPanelContent
                anchors.fill: parent
                anchors.margins: 3

                Rectangle {
                    id: saturationDot
                    property var pointY: 0
                    x: 0
                    y: saturationDot.pointY - height/2
                    width: parent.width
                    height: 5
                    radius: 1
                    border.width: 1
                    border.color: "#00A2F6"
                    color: "transparent"
                    z: 100


                }

                // 三角
                Triangle {
                    z: 100
                    width: 19
                    height: 19
                    anchors.left:  saturationDot.right
                    y: saturationDot.pointY - height/2
                    rotation: 180
                }

                MouseArea {
                    anchors.fill: parent

                    onPositionChanged: {

                        saturationDot.pointY = mouseY < 0 ? 0 : mouseY >height ? height : mouseY

                        saturationVale =  (height - saturationDot.pointY) / height

                        setColorFromSaturation();

                    }
                    onClicked: {
                        saturationDot.pointY = mouseY

                        saturationVale =  (height - saturationDot.pointY) / height

                        setColorFromSaturation();
                    }
                }


            }


            Canvas {
                id: saturationPanelCanvas
                anchors.fill: saturationPanelContent
                parent: saturationPanelContent
                onPaint: {
                    var ctx = getContext("2d");
                    var linear = ctx.createLinearGradient(0,0,0,height);

                    var maxColor = Math.max(selectColor.r,selectColor.b,selectColor.g);

                    linear.addColorStop(0, selectColor);
                    linear.addColorStop(1.0, Qt.rgba(maxColor,maxColor,maxColor,1));
                    ctx.fillStyle = linear;
                    ctx.fillRect(0,0,width,height);

                }

                Connections {
                    target: container
                    onSelectColorChanged: {
                        saturationPanelCanvas.requestPaint()
                    }
                }
            }

        }


    }
}
