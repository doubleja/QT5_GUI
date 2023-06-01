import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12
Popup {
     id: popup

     // 设置水平位置
     enum HorizontalPosBase {
         PosBaseToLeft,                 // popup位于目标水平左侧
         PosBaseToHorizontalLeft,       // popup位于目标水平中心左侧对齐
         PosBaseToHorizontal,           // popup位于目标水平中心
         PosBaseToHorizontalRigh,       // popup位于目标水平中心右侧对齐
         PosBaseToRight                 // popup位于目标水平右侧
     }
     // 垂直对齐方式
     enum VerticalPosBase {
         TopAlign,                  // popup的顶部与目标进行对齐
         VerticalAlign,             // popup与目标垂直对齐
         BottomAlign,               // popup的底部与目标底部进行对齐

         // 下面只有当 horizontalPosBase = PosBaseToHorizontalLeft | PosBaseToHorizontal | PosBaseToHorizontalRigh时使用
         PosBaseToTop,              // popup的Y坐标位于目标的上面
         PosBaseToBottom            // popup的Y坐标位于目标的下面
     }

     property int horizontalPosBase: IndicatorPopup.PosBaseToHorizontal
     property int verticalPosBase: IndicatorPopup.PosBaseToBottom

     property int backgroundRadius: 5       // popup圆边框
     property int indicatorLen: 8           // 指示器长度
     property var backgroundColor: "#44D2FF"   // 背景色
     property int targetSpacing: 3          // popup与目标的间隔

     implicitWidth: 120
     implicitHeight: 120

     modal: true
     focus: true
     background: Rectangle {
        id: back

        color: backgroundColor
        anchors.fill: parent
        radius: backgroundRadius
        Rectangle {
            id: indicator
            width: Math.sqrt(Math.pow(indicatorLen,2)*2)
            height: width
            rotation: 45
            color: backgroundColor
            opacity: back.opacity
            z:2
        }
     }

     property var myTarget
     function indicatorOpen(target) {
         myTarget = getGlobalPos(target);
         updatePopupPos();
         popup.open();
     }



     // 指示器方向,根据horizontalPosBase和verticalPosBase 自动计算
     enum IndicatorStyle {
         IndicatorLeft,
         IndicatorRight,
         IndicatorTop,
         IndicatorBottom
     }

     function updateIndicatorPos(indicatorStyle) {

          switch (indicatorStyle)
         {
             case IndicatorPopup.IndicatorLeft:
                 indicator.x = - indicator.width*0.4;
                 indicator.y =  back.height <= myTarget.height ? (back.height)/2-indicatorLen :
                                verticalPosBase === IndicatorPopup.TopAlign ? (myTarget.height)/2 -indicatorLen :
                                verticalPosBase === IndicatorPopup.VerticalAlign ? (back.height)/2 -indicatorLen :
                                back.height -  (myTarget.height)/2 -indicatorLen;

                 break;

             case IndicatorPopup.IndicatorRight:
                 indicator.x = width - indicator.width*1.2;
                 indicator.y =  back.height <= myTarget.height ? (back.height)/2-indicatorLen :
                                verticalPosBase === IndicatorPopup.TopAlign ? (myTarget.height)/2 -indicatorLen :
                                verticalPosBase === IndicatorPopup.VerticalAlign ? (back.height)/2 -indicatorLen :
                                back.height -  (myTarget.height)/2 -indicatorLen;
                 break;

             case IndicatorPopup.IndicatorTop:
                 indicator.x =  back.width <= myTarget.width ? (back.width)/2-indicatorLen :
                                horizontalPosBase === IndicatorPopup.PosBaseToHorizontalLeft ? (myTarget.width)/2 -indicatorLen :
                                horizontalPosBase === IndicatorPopup.PosBaseToHorizontal ? (back.width)/2 -indicatorLen :
                                back.width -  (myTarget.width)/2 -indicatorLen;
                 indicator.y =  - indicator.width*0.4;
                 break;
             case IndicatorPopup.IndicatorBottom:
                 indicator.x =  back.width <= myTarget.width ? (back.width)/2-indicatorLen :
                                horizontalPosBase === IndicatorPopup.PosBaseToHorizontalLeft ? (myTarget.width)/2 -indicatorLen :
                                horizontalPosBase === IndicatorPopup.PosBaseToHorizontal ? (back.width)/2 -indicatorLen :
                                back.width -  (myTarget.width)/2 -indicatorLen;
                 indicator.y =  height - indicator.height*1.2;
                 break;
         }


        // console.log("indicator",indicator.x,indicator.y,indicator.width,indicator.height)
     }

     function updatePopupPos() {
        var indicatorStyle;

         switch (horizontalPosBase)
        {
            case IndicatorPopup.PosBaseToLeft:     // popup位于目标水平左侧

                x = myTarget.x - width - targetSpacing;
                y = verticalPosBase === IndicatorPopup.TopAlign ? myTarget.y :
                    verticalPosBase === IndicatorPopup.VerticalAlign ? myTarget.y + myTarget.height/2 - height/2 :
                    myTarget.y - height + myTarget.height
                indicatorStyle = IndicatorPopup.IndicatorRight;

                break;

            case IndicatorPopup.PosBaseToHorizontalLeft: // popup水平中间左侧
                x = myTarget.x ;
                y = verticalPosBase === IndicatorPopup.PosBaseToTop ? myTarget.y - height - targetSpacing :
                    verticalPosBase === IndicatorPopup.PosBaseToBottom ? myTarget.y + myTarget.height + targetSpacing :
                    myTarget.y + myTarget.height + targetSpacing

                indicatorStyle = verticalPosBase === IndicatorPopup.PosBaseToTop ? IndicatorPopup.IndicatorBottom :
                                                                                   IndicatorPopup.IndicatorTop;
                break;

            case IndicatorPopup.PosBaseToHorizontal: // popup水平中间
                x = myTarget.x + myTarget.width/2 - width/2;
                y = verticalPosBase === IndicatorPopup.PosBaseToTop ? myTarget.y - height - targetSpacing :
                    verticalPosBase === IndicatorPopup.PosBaseToBottom ? myTarget.y + myTarget.height + targetSpacing :
                    myTarget.y + myTarget.height + targetSpacing

                indicatorStyle = verticalPosBase === IndicatorPopup.PosBaseToTop ? IndicatorPopup.IndicatorBottom :
                                                                                   IndicatorPopup.IndicatorTop;
                break;

            case IndicatorPopup.PosBaseToHorizontalRigh: // popup水平中间右侧
                x = myTarget.x + myTarget.width - width;
                y = verticalPosBase === IndicatorPopup.PosBaseToTop ? myTarget.y - height - targetSpacing :
                    verticalPosBase === IndicatorPopup.PosBaseToBottom ? myTarget.y + myTarget.height + targetSpacing :
                    myTarget.y + myTarget.height + targetSpacing

                indicatorStyle = verticalPosBase === IndicatorPopup.PosBaseToTop ? IndicatorPopup.IndicatorBottom :
                                                                                   IndicatorPopup.IndicatorTop;
                break;


            case IndicatorPopup.PosBaseToRight:   // popup位于目标水平右侧

                x = myTarget.x + myTarget.width + targetSpacing;
                y = verticalPosBase === IndicatorPopup.TopAlign ? myTarget.y :
                    verticalPosBase === IndicatorPopup.VerticalAlign ? myTarget.y + myTarget.height/2 - height/2 :
                    myTarget.y - height + myTarget.height
                indicatorStyle = IndicatorPopup.IndicatorLeft
                break;
        }

        back.anchors.leftMargin = indicatorStyle === IndicatorPopup.IndicatorLeft ? indicatorLen : 0
        back.anchors.rightMargin = indicatorStyle === IndicatorPopup.IndicatorRight ? indicatorLen : 0
        back.anchors.bottomMargin = indicatorStyle === IndicatorPopup.IndicatorBottom ? indicatorLen : 0
        back.anchors.topMargin = indicatorStyle === IndicatorPopup.IndicatorTop ? indicatorLen : 0

        leftPadding = indicatorStyle === IndicatorPopup.IndicatorLeft ? indicatorLen : 0
        rightPadding = indicatorStyle === IndicatorPopup.IndicatorRight ? indicatorLen : 0
        bottomPadding = indicatorStyle === IndicatorPopup.IndicatorBottom ? indicatorLen : 0
        topPadding = indicatorStyle === IndicatorPopup.IndicatorTop ? indicatorLen : 0


        updateIndicatorPos(indicatorStyle);

     }


     function getGlobalPos(targetObject) {
        var positionX = 0
        var positionY = 0
        var obj = targetObject

        /* 遍历所有的父窗口 */
        while (obj != null) {
            positionX += obj.x
            positionY += obj.y

            obj = obj.parent
        }

        return {"x": positionX, "y": positionY, "width": targetObject.width, "height": targetObject.height}
    }

}
