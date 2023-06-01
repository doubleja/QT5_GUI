import QtQuick 2.12
import QtQuick.Controls 2.12

Button {
    id: container
    implicitWidth: 38
    implicitHeight: 24
    property var imageSrc: ''
    property var hoverimageSrc: null
    property var backHoverColor: 'transparent'
    property var backColor: 'transparent'

    clip: true
    background: Rectangle {
       anchors.fill: container
       color: container.hovered ? backHoverColor : backColor
       Image {
           anchors.centerIn: parent
           antialiasing: true
           source: container.hovered ? (hoverimageSrc == null? imageSrc : hoverimageSrc)
                                  : imageSrc
           fillMode: Image.PreserveAspectFit
       }
    }



}
