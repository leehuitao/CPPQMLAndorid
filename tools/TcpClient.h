#ifndef TCPCLIENT_H
#define TCPCLIENT_H

#include <QObject>
#include <QTcpSocket>
#include <QAbstractSocket>
class TcpClient:public QObject
{
    Q_OBJECT
public:

    explicit TcpClient(QObject *parent = nullptr);
    ~TcpClient();

    Q_INVOKABLE void connect(QString ip,QString port);
    Q_INVOKABLE bool sendMessage(QString sendStr);
    Q_INVOKABLE bool sendHexMessage(QString sendStr);
    Q_INVOKABLE QString receiveMesage();
    Q_INVOKABLE void closeconnect();
    Q_INVOKABLE bool sendImagePath(QString );
    void procMesage(std::string &message);
signals:
    //  链接状态
    void connectStatus(int type);
    void readable();
    void noticeMsg(QString title ,QString body);
public slots:

    void connected();
    void displayError(QAbstractSocket::SocketError);
    void readyread();



private:
    QTcpSocket *m_socket;
};

#endif // TCPCLIENT_H
