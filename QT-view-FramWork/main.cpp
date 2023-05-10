#include "mainwindow.h"

#include <QApplication>
#include <QStandardItemModel>
#include <QTableView>
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    w.show();
    QStandardItemModel model(3,3);//创建一个3行3列表格结构模型
    QTableView v1;//创建一个表格视图
//  设置模型的数据，使用索引的形式设置每一个数据项的值
    model.setData(model.index(0,0),123);
    model.setData(model.index(0,1),222);
    model.setData(model.index(0,2),333);
    model.setData(model.index(1,0),444);
    model.setData(model.index(1,1),555);
    model.setData(model.index(1,2),666);
    model.setData(model.index(2,0),777);
    model.setData(model.index(2,1),888);
    model.setData(model.index(2,2),999);


    v1.setModel(&model);//设置视图1的模型
    v1.show();//显示视图
    return a.exec();
}
