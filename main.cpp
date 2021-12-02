#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <tools/TcpClient.h>
#include <tools/LogTool.h>
#include <tools/CameraFromQML.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    qmlRegisterType<TcpClient>("TcpClient",1,0,"TcpClient");
    qmlRegisterType<CameraFromQML>( "CameraFromQML", 1, 0, "CameraFromQML" );

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
    LogTool::Instance()->installMessageHandler();
    return app.exec();
}
