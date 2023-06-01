import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import QtQuick.Controls.Material 2.12
import "qrc:/common"
import "qrc:/Palette"
ApplicationWindow  {
    id: root
    visible: true
    width: 850
    height: 699
    title: qsTr("QML调色板与样式自定义demo")
    property string defaultAccent: "#FF0059"
    PalettePopup {
           id: palette_popup
    }

    menuBar: MenuBar {
        Menu {
             id: fileMenu
             title: qsTr("主题样式")
             Switch {
                 text: qsTr("高亮主题")
                 onCheckedChanged: {
                     root.Material.theme = checked? Material.Light : Material.Dark
                     console.log(root.Material.theme)
                 }
                 checked: true
             }

             MenuItem {
               text: qsTr("自定义重色")
               onClicked: palette_popup.open()
             }
         }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        anchors.leftMargin: 100

        TabBar {
              id: bar
              Layout.fillWidth: true
              TabButton {
                  text: qsTr("Home")
              }
              TabButton {
                  text: qsTr("Discover")
              }
              TabButton {
                  text: qsTr("Activity")
              }
          }

        RowLayout {
            spacing: 30
            BusyIndicator {
                 running: true
            }

            Dial {

               snapMode: Dial.SnapAlways;
               stepSize: 0.1;
            }

        }


        RowLayout {
            YaheiText {
                text: "RadioButton: "
            }

            RadioButton {
              checked: true
              text: qsTr("First")
            }
            RadioButton {
              text: qsTr("Second")
            }
            RadioButton {
              text: qsTr("Third")
            }
        }

        RowLayout {
            YaheiText {
                text: "CheckBox: "
            }
            CheckBox {
              checked: true
              text: qsTr("First")
            }
            CheckBox {
              text: qsTr("Second")
            }
            CheckBox {
              checked: true
              text: qsTr("Third")
            }
        }





        RowLayout {
              spacing: 20
              Switch {
                  text: qsTr("Wi-Fi")
              }
              Switch {
                  text: qsTr("Bluetooth")
                  checked: true
              }
              SpinBox {
                    value: 50
              }
        }

        RowLayout {
            Layout.preferredHeight: 40
            YaheiText {
                text: "滑动器: "
            }

            Slider {
                  background.implicitHeight: 10
                  from: 1
                  value: 25
                  to: 100
            }
        }
        RowLayout {
            Layout.preferredHeight: 40
            YaheiText {
                text: "进度条: "
            }

            ProgressBar {
                id: progress
                value: 0.0
                background.width: 300
                contentItem.width: 300
                Timer {
                    repeat: true
                    interval: 100
                    running: true
                    onTriggered: {
                        progress.value =  (progress.value + 0.05) > 1.0 ? 0 : (progress.value + 0.05)
                    }
                }
            }
        }

        RowLayout {
          spacing: 20
          Button {
              text: "Ok"
              Material.accent: Material.Green
          }
          Button {
              text: "Cancel"
          }
        }

        RowLayout {

            Text {
                text: "ComboBox: "
                font.pixelSize: 14
                font.family: "Microsoft Yahei"
                color: Material.foreground
            }

            ComboBox {
                  model: ["First", "Second", "Third"]
            }
        }



    }


    Material.accent: defaultAccent

}
