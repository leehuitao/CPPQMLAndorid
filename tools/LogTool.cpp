#include "LogTool.h"

#include <QMutex>
#include <iostream>
#include <QDateTime>
#include <QCoreApplication>
#include <QFile>
#include <QDir>
#include <QTextStream>
//接收调试信息的函数
void outputMessage(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    QString headMsg=msg.left(4);
    //    qDebug()<<headMsg;

    if(headMsg=="API="||headMsg=="RESU"||headMsg=="Call"||headMsg=="LIST"){
    }else {
        // 一般 直接
        std::cout << msg.toStdString() << std::endl;
        return;
    }
    static QMutex mutex;
    QMutexLocker lock(&mutex);

    QString text;
    switch(type)
    {
    //如果是debug信息，那么直接打印至应用程序输出，然后退出本函数
    case QtDebugMsg:
        std::cout << msg.toStdString() << std::endl;
        return ;

        //如果是警告，或者是下面的其他消息，则继续执行后面的数据处理
    case QtWarningMsg:
        text = QString("Warning...............................");
        break;

    case QtCriticalMsg:
        text = QString("Critical..............................");
        break;

    case QtFatalMsg:
        text = QString("Fatal.................................");
        break;

    default:
        text = QString("Default...............................");
        break;
    }
    //获取单例
    LogTool *instance = LogTool::Instance();
    //消息输出位置
    QString context_info = QString("File: %1\r\nFunc: %2\r\nLine: %3")
            .arg(QString(context.file))
            .arg(QString(context.function))
            .arg(context.line);
    //消息打印时间
    QString current_date_time = QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss ddd");
    QString current_date = QString("Time: %1")
            .arg(current_date_time);
    //调试信息
    QString message = QString("[%1]:[%2]\r\n")
            .arg(current_date)
            .arg("MSG:"+msg);
    //  //log 位置

    //将调试信息写入文件
    QFile file(instance->logPath() + instance->logName());
    file.open(QIODevice::WriteOnly | QIODevice::Append);
    QTextStream text_stream(&file);
    text_stream << message << "\r\n";
    file.flush();
    file.close();
    //将处理好的调试信息发送出去
    instance->sigDebugStrData(message);
    //将处理成 html 的调试信息发送出去
    //检查文件是否达到了指定大小

    if(file.size() < 1024*1024) {
        return ;
    }
    //log达到了限制值则将名字更改，防止文件越来越大
    for(int loop = 1; loop < 100; ++loop) {
        QString fileName = QString("%1/log_%2.txt").arg(instance->logPath()).arg(loop);
        QFile file_1(fileName);
        if(file_1.size() < 4) {
            file.rename(fileName);
            return ;
        }
    }
}

//LogTool单例
LogTool* LogTool::self = nullptr;
LogTool* LogTool::Instance()
{
    if(!self) {
        QMutex muter;
        QMutexLocker clocker(&muter);

        if(!self) {
            self = new LogTool();
        }
    }
    return self;
}
//安装消息器
void LogTool::installMessageHandler()
{
    qInstallMessageHandler(outputMessage);
}
//卸载消息器
void LogTool::uninstallMessageHandler()
{
    qInstallMessageHandler(0);
}
//建立文件路径
QString LogTool::logPath()
{
    QString current_date_file_name = QDateTime::currentDateTime().toString("yyyy-MM-dd");
    QDir dir(QString("%1/UIlog/%2").arg("./").arg(current_date_file_name));
    if(!dir.exists()) {
        dir.mkpath("./");
    }
    return dir.path() + "/" ;
}

QString LogTool::logName()
{
    return "log.txt";
}

LogTool::LogTool(QObject *parent) : QObject(parent)
{
    static LogTool::GC gc;
}

LogTool::~LogTool()
{
    std::cout << "~LogTool" << std::endl;
}

//垃圾自动回收
LogTool::GC::~GC()
{
    if (self != nullptr) {
        delete self;
        self = nullptr;
    }
}
