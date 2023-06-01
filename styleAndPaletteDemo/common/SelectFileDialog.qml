import QtQuick 2.12
import Qt.labs.platform 1.0
FileDialog {
    title: "打开文件"
    acceptLabel: "确定"
    rejectLabel: "取消"
    fileMode: FileDialog.OpenFile
    nameFilters: ["image files (*.png *.jpg)"]
    onAccepted: {
        console.log("选中的文件有:")
        for (var i in files) {
            console.log(files[i])
        }
    }
}
