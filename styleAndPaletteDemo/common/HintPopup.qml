import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
Popup {
  id: _popup
  property string hint: "ERROR ERROR ERROR"
  property string hintColor: "#8E8E8E"
  property int bckRadius: 1

  signal accept();
  signal reject();
  property bool acceptFlg: false

  background: Rectangle {
      implicitWidth: 200
      implicitHeight: 200
      radius: bckRadius
      layer.enabled: true
      layer.effect: DropShadow {
         visible: !_enterAnima.running & !_exitAnima.running
      }
      ImageButton {
          anchors.right: parent.right
          imageSrc: "qrc:/res/close.png"
          hoverimageSrc:"qrc:/res/close_hover.png"
          backHoverColor: "#FA5151"
          ToolTip.delay: 1000              // 徘徊在按钮上超过500ms则显示,则默认为直接显示
          ToolTip.visible: hovered       // 当鼠标徘徊在按钮上时,则显示ToolTip
          ToolTip.text: qsTr("关闭")
          onClicked: {
              acceptFlg = false;
              close();
          }
      }
  }
  padding: 30

  ColumnLayout {
      id: _content
      spacing: 20
      anchors.centerIn: parent
      YaheiText {
          text: hint
          font.pixelSize: 15
          color: hintColor
          Layout.alignment: Qt.AlignCenter
      }

      BaseButton {
          id: _enter
          btnText: "确定"
          fontSize: 15
          bckcolor: hintColor
          bckHoverColor: Qt.lighter(hintColor, 0.8)
          Layout.alignment: Qt.AlignCenter
          onClicked: {
              acceptFlg = true;
              close();
          }
          Layout.fillWidth: true
          Layout.preferredHeight: 28
          backRadius: 10
      }
  }
  modal: false
  focus: true
  closePolicy: Popup.CloseOnEscape

  enter: Transition {
        id: _enterAnima
        NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 200;  }
        ScriptAction {
            script: acceptFlg = false;
        }
  }
  exit: Transition {
        id: _exitAnima
        SequentialAnimation {
          NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 200; }
          ScriptAction {
              script: acceptFlg ? accept() : reject();
          }
        }
  }
}
