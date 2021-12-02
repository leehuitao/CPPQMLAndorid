#ifndef CAMERAFROMQML_H
#define CAMERAFROMQML_H

#include <QObject>

#include <QObject>
#include <QVideoProbe>
#include <QVideoFrame>
#include <QVideoSurfaceFormat>
#include <QCamera>
#include <QDateTime>
#include <QThread>

class CameraFromQML : public QObject
{
    Q_OBJECT

    //Qt属性，与QML对象属性类似
    Q_PROPERTY( QObject* qmlCamera READ getQmlCamera WRITE setQmlCamera )

public:
    explicit CameraFromQML( QObject *parent = nullptr  );
    Q_INVOKABLE void onCaptureImage(QString path);
    //获取类的属性, 返回_qmlCamera对象
    QObject *getQmlCamera() const;

    //设置类的属性qmlCamera, 传入QML对象Camera，然后将_qmlCamera设置为qmlCamera
    void setQmlCamera( QObject *qmlCamera );

private slots:

    //槽函数：与QVIdeoProbe的videoFrameProbe信号绑定，在这个槽函数可以对摄像头捕获到的每一帧进行自定义处理
    void _onProcssFram( const QVideoFrame &frame );
private:

    //从QML获取到的Camera对象
    QObject *_qmlCamera = nullptr;

    //在C++中的QCamera对象
    QCamera *_camera = nullptr;

    //QVideoProbe类，只能在Android设备上使用，当设备的摄像头有帧数据的时候，会发出videoFrameProbed信号
    QVideoProbe _probe;

    //调试时，计算获取每一帧的时间使用的变量
    qint64 lastTime = 0;
};

#endif // CAMERAFROMQML_H
