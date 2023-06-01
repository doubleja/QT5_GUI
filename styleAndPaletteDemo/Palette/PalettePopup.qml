import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
import QtQuick.Controls.Material 2.12
import "qrc:/common"
Popup {
  id: _popup

  property real opacityValue: 1.0
  property real rValue: 1.0
  property real gValue: 1.0
  property real bValue: 1.0

  background: Rectangle {
      implicitWidth: 650
      implicitHeight: 420
      color: Material.background
      radius: 1
      layer.enabled: true
      layer.effect: DropShadow {
         visible: !_enterAnima.running & !_exitAnima.running
         color: Material.foreground
      }
      ImageButton {
          anchors.right: parent.right
          imageSrc: "qrc:/res/close.png"
          hoverimageSrc:"qrc:/res/close_hover.png"
          backHoverColor: "#FA5151"
          onClicked: close();
      }
      YaheiText {
          text: "☺调色板定义"
          x: 14
          y: 4
          color: Material.accent
      }
      Rectangle {
          height: 1
          color: "#DEDEDE";
          width: parent.width
          y: 33
      }
      Row {
          spacing: 12
          anchors.bottom: parent.bottom
          anchors.left: parent.left
          anchors.leftMargin: 23
          anchors.bottomMargin: 5
          YaheiText {
              text: "透明度"
              font.pixelSize: 13
              color: Material.accent
              anchors.verticalCenter: parent.verticalCenter
          }
          BaseSlider {
              id: _slider
              styleColor: Material.accent
              from: 0.4
              to: 1.0
              value: 1.0 - opacityValue
              onMoved: {
                opacityValue = 1.0 - value;
                root.Material.accent = Qt.rgba(palette.selectColor.r, palette.selectColor.g,
                                               palette.selectColor.b, opacityValue)
              }
          }
      }
      Row {
          anchors.bottom: parent.bottom
          anchors.right: parent.right
          anchors.rightMargin: 23
          anchors.bottomMargin: 8
          BaseButton {
              btnText: "恢复默认"
              height: 26
              width: 75
              fontSize: 13
              bckcolor: Material.accent
              anchors.verticalCenter: parent.verticalCenter
              backRadius: 5
              onClicked: {
                   palette.resetDot()
                   root.Material.accent = root.defaultAccent
                   palette.selectColor = Qt.rgba(Material.accent.r, Material.accent.g,Material.accent.b)
                   opacityValue = 1.0

              }
          }
      }
  }

  // 调色板
  Palette {
      id: palette
      anchors.fill: parent
      anchors.topMargin: 30
      anchors.bottomMargin: 30
      onColorChange:  {
        root.Material.accent = c
      }
      Component.onCompleted: selectColor = Qt.rgba(Material.accent.r, Material.accent.g,Material.accent.b)
  }

  modal: true
  dim: false
  focus: true

  parent: Overlay.overlay
  x: Math.round((parent.width - width) / 2)
  y: Math.round((parent.height - height) / 2)

  closePolicy: Popup.CloseOnEscape

  enter: Transition {
        id: _enterAnima
        NumberAnimation { property: "scale"; from: 0.0; to: 1.0; duration: 200; easing.type : Easing.OutBack }
        NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 300;  }

  }
  exit: Transition {
        id: _exitAnima
        NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 300; }
  }
}
