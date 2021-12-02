#include "TcpClient.h"
#include "innertype.h"
#include <QBuffer>
#include <QDebug>
#include <QImage>
#include <QPixmap>
TcpClient::TcpClient(QObject *parent): QObject(parent)
{
    m_socket = new QTcpSocket;
}

void TcpClient::connect(QString ip,QString port)
{
    m_socket->connectToHost(ip, port.toInt());
    QObject::connect(this->m_socket,SIGNAL(connected()),this,SLOT(connected()));
    QObject::connect(this->m_socket,SIGNAL(readyRead()),this,SLOT(readyread()));
    QObject::connect(m_socket, QOverload<QAbstractSocket::SocketError>::of(&QAbstractSocket::error), this, &TcpClient::displayError);
    qDebug()<<"test qWarning";

}

void TcpClient::connected()
{
    // 链接成功
    qDebug()<<" connect success ! ";
    emit connectStatus(1);
}

void TcpClient::displayError(QAbstractSocket::SocketError error )
{
    QString err(error);
    qDebug()<<"err = "<<err;
}

void TcpClient::readyread(){
    // 消息可读取
    qDebug()<<" readyread ! ";
    emit readable();

}

bool TcpClient::sendMessage(QString sendStr)
{
    if (!m_socket->isOpen())
    {
        // 关闭了
        emit noticeMsg("System" , "网络已断开 , 请重新链接!");
        return  false;
    }
    std::string hexdata = HexToString(sendStr.toStdString());

    if(m_socket->write(sendStr.toLatin1().data(),strlen(sendStr.toLatin1().data())))
    {
        return true;
    }
    else {
        return false;
    }
}


bool TcpClient::sendHexMessage(QString sendStr)
{
    if (!m_socket->isOpen())
    {
        // 关闭了
        emit noticeMsg("System" , "网络断开 , 请重新链接!");
        return  false;
    }
    std::string hexdata = HexToString(sendStr.toStdString());

    qDebug()<<"sendHexMessage : "<< sendStr;

    if(m_socket->write(hexdata.c_str(),hexdata.length()))
    {
        return 1;
    }
    else {
        return 0;
    }
}
QString TcpClient::receiveMesage()
{
    QByteArray recvData = m_socket->readAll();
    return recvData;

}

void TcpClient::closeconnect()
{
    m_socket->close();
}

bool TcpClient::sendImagePath(QString path)
{
    QImage img(path);
    if(m_socket->state() == QAbstractSocket::ConnectedState){   //如果连接上再进行传输，避免bug

        QPixmap pixmap = QPixmap::fromImage(img);  //把img转成位图，我们要转成jpg格式
        QByteArray ba;
        QBuffer buf(&ba); //把ba绑定到buf上，操作buf就等于操作ba
        //pixmap.save(&buf,"jpg",50); //把pixmap保存成jpg，压缩质量50 数据保存到buf
        //先写大小过去，告诉主机我们要传输的数据有多大
        m_socket->write(QString("size=%1").arg(ba.size()).toLocal8Bit().data());
        m_socket->waitForBytesWritten();//等待发送结束
        m_socket->write(ba);//把图像数据写入传输给主机
        m_socket->waitForBytesWritten(); //等待发送结束
    }
    return 1;
}

void TcpClient::procMesage(std::string &message)
{
    qDebug()<<"recv : "<<QString::fromStdString(message);
}

TcpClient::~TcpClient()
{
    if(m_socket->isOpen())
    {
        m_socket->disconnectFromHost();
    }
    delete m_socket;

}
