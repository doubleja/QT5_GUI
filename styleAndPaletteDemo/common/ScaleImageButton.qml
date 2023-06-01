import QtQuick 2.12
import QtQuick.Controls 2.5

Button {
    id: container
    implicitWidth: 38
    implicitHeight: 24
    property bool shrink: true  // 缩小
    property var normalImage: 'qrc:/res/scale1.png'       // 正常
    property var maxImage: 'qrc:/res/scale0.png'          // 放大

    property var backHoverColor: '#20334455'
    property var backColor: 'transparent'

    clip: true
    background: Rectangle {
       color: container.hovered ? backHoverColor : backColor
       Image {
           anchors.centerIn: parent
           antialiasing: true
           source: shrink ? normalImage : maxImage
           fillMode: Image.PreserveAspectFit
       }
   }

   onClicked: {
       shrink = !shrink
   }
}
