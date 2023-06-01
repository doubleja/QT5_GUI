pragma Singleton
import QtQuick 2.12
import QtQml.Models 2.12

Item {


    property list<Gradient> skins : [
       Gradient {
           property string name: "午夜巴黎"
           property string popupColor: "#7C56FF"
           property string loginColor: "#7C56FF"
           orientation: Gradient.Horizontal;
           GradientStop { position: 0.0; color: "#12B4FF" }
           GradientStop { position: 0.15; color: "#3297FF" }
           GradientStop { position: 1.0; color: "#B822FF" }
       },
        Gradient {
            property string name: "樱草青葱"
            property string popupColor: "#00AEF6"
            property string loginColor: "#00AEF6"
            orientation: Gradient.Horizontal;
            GradientStop { position: 0.0; color: "#00AEF6" }
            GradientStop { position: 0.3; color: "#00C2CB" }
            GradientStop { position: 0.7; color: "#00DA98" }
            GradientStop { position: 1.0; color: "#00EB73" }

        },
        Gradient {
            property string name: "秋日暖阳"
            property string popupColor: "#FF5245"
            property string loginColor: "#FF5245"
            orientation: Gradient.Horizontal;
            GradientStop { position: 0.0; color: "#FF7C20" }
            GradientStop { position: 0.3; color: "#FF4750" }
            GradientStop { position: 0.7; color: "#FF177A" }
            GradientStop { position: 1.0; color: "#FF0090" }
        },
        Gradient {
            property string name: "默认黑"
            property string popupColor: "#696969"
            property string loginColor: "#1AAD19"
            orientation: Gradient.Horizontal;
            GradientStop { position: 0.0; color: "#28292C" }
        },
        Gradient {
            property string name: "淡灰色"
            property string popupColor: "#979797"
            property string loginColor: "#979797"
            orientation: Gradient.Horizontal;
            GradientStop { position: 0.0; color: "#C4C4C4" }
        },
        Gradient {
            property string name: "蓝绿色"
            property string popupColor: "#00BEAC"
            property string loginColor: "#00BEAC"
            orientation: Gradient.Horizontal;
            GradientStop { position: 0.0; color: "#00BEAC" }
        },
        Gradient {
            property string name: "橙色"
            property string popupColor: "#FF9800"
            property string loginColor: "#FF9800"
            orientation: Gradient.Horizontal;
            GradientStop { position: 0.0; color: "#FF9800" }
        },
        Gradient {
            property string name: "咖啡色"
            property string popupColor: "#8C6450"
            property string loginColor: "#8C6450"
            orientation: Gradient.Horizontal;
            GradientStop { position: 0.0; color: "#8C6450" }
        },
        Gradient {
            property string name: "绿色"
            property string popupColor: "#79BE3C"
            property string loginColor: "#79BE3C"
            orientation: Gradient.Horizontal;
            GradientStop { position: 0.0; color: "#79BE3C" }
        },
        Gradient {
            property string name: "粉色"
            property string popupColor: "#FF9800"
            property string loginColor: "#FF9800"
            orientation: Gradient.Horizontal;
            GradientStop { position: 0.0; color: "#FF9800" }
        },
        Gradient {
            property string name: "紫色"
            property string popupColor: "#673AB7"
            property string loginColor: "#673AB7"
            orientation: Gradient.Horizontal;
            GradientStop { position: 0.0; color: "#673AB7" }
        },
        Gradient {
            property string name: "蓝色"
            property string popupColor: "#00BCD4"
            property string loginColor: "#00BCD4"
            orientation: Gradient.Horizontal;
            GradientStop { position: 0.0; color: "#00BCD4" }
        },
        Gradient {
            property string name: "蓝灰色"
            property string popupColor: "#507EA4"
            property string loginColor: "#507EA4"
            orientation: Gradient.Horizontal;
            GradientStop { position: 0.0; color: "#507EA4" }
        },
        Gradient {
            property string name: "红色"
            property string popupColor: "#F45E63"
            property string loginColor: "#F45E63"
            orientation: Gradient.Horizontal;
            GradientStop { position: 0.0; color: "#F45E63" }
        }
    ]


}
