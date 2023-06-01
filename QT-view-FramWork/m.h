#ifndef M_H
#define M_H
#include <QtWidgets>
#include <iostream>
using  namespace std;

class D: public QAbstractItemModel{

public:
    //模型数据的行数和列数
    int col,rw;
    QList<QVariant> sl; //模型管理的数据
    QList<int> rol;//存储数据的角色

    //构造函数表示创建一个i行j列的表格模型
    D(int i,int j):rw(i),col(j){
        for (int k=0;k<col*rw;k++){sl<<QVariant();rol<<-1;}
    //1、返回表格模型的行数
        int rowCount(const QModelIndex &parent =QModelIndex()) COMST{ return rw;}
    //2、返回表格模型的列数
        int columnCount(const QModelIndex &parent = QModelIndex()) const {return col;}
    //3、返回表格模型的父索引，因为所有单元格都是顶级节点，所以使用无效节点作为父节点
        QModelIndex parent (const QModelIndex &index)const{

            return QModelIndex;
        }
    //4、为每个单元格创造一个唯一索引

        QModelIndex Index(int row ,int column,const QModelIndex)



    }

};

#endif // M_H
