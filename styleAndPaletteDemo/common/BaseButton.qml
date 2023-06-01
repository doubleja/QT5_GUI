import QtQuick 2.12
import QtQuick.Controls 2.5

Button {
    id: container
    property string btnText: ""
    property string bckcolor: "#1AAD19"
    property string bckHoverColor: Qt.lighter(bckcolor, 0.8)
    property int fontSize: 20
    property int backRadius: 0

    text: btnText
    font.family: "Microsoft Yahei"
    font.pixelSize: fontSize
    implicitWidth: 100
    implicitHeight: 40
    contentItem: Text {
        text: container.text
        font: container.font
        color: "#fff"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    background: Rectangle {
        anchors.fill: parent
        radius: backRadius
        color: container.down ? bckcolor :
                 container.hovered ? bckHoverColor : bckcolor

    }
}
