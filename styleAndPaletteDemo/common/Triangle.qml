import QtQuick 2.10

//三角形框

Item {
    id: root
    property int angle: 0
    property color color: "#00A2F6"
    implicitWidth: 100
    implicitHeight: 100
    clip: true

    Canvas {
       id: canvas
       anchors.fill: parent
       contextType: "2d"
       Connections {
           target: root
           onVisibleChanged: if (visible) {
                                canvas.requestPaint()
                             }
       }

       onPaint: {
           var context = getContext("2d");
           context.reset();
           context.moveTo(width-10, height/2-4);
           context.lineTo(width, height/2);
           context.lineTo(width-10, height/2+4);

           context.closePath();
           context.fillStyle = root.color
           context.fill();
       }
   }
}
