#include "CameraFromQML.h"

#ifdef Q_OS_ANDROID
#include <QtAndroidExtras/QtAndroid>
#include <QtAndroidExtras/QAndroidJniObject>
#include <QtAndroidExtras/QAndroidJniEnvironment>
#endif

#include <QDebug>
#include <QDialog>
#include <QDir>
#include <QFile>
#include <QLabel>

CameraFromQML::CameraFromQML( QObject *parent ) :
    _qmlCamera( nullptr ),
    _camera( nullptr )
{
    Q_UNUSED( parent )
}

bool copyFileToPath(QString sourceDir ,QString toDir, bool coverFileIfExist  = 1)
{
    if (sourceDir == toDir){
        return true;
    }
    if (!QFile::exists(sourceDir)){
        return false;
    }
    QDir *createfile     = new QDir;
    bool exist = createfile->exists(toDir);
    if (exist){
        if(coverFileIfExist){
            createfile->remove(toDir);
        }
    }//end if

    if(!QFile::copy(sourceDir, toDir))
    {
        return false;
    }
    return true;
}

void CameraFromQML::onCaptureImage(QString path)
{
    qDebug()<<"capture path = "<<path;
    auto ret = copyFileToPath(path,"\\\\192.168.101.145\\sharedimg\\camera.jpg");
    qDebug()<<"ret = "<<ret;


}

QObject *CameraFromQML::getQmlCamera() const
{
    return _qmlCamera;
}

void CameraFromQML::setQmlCamera( QObject *qmlCamera )
{
    if(0){
        this->_qmlCamera = qmlCamera;
        if( _qmlCamera )
        {
            //将QML对象转换为C++对象
            _camera = qvariant_cast< QCamera* >( _qmlCamera->property( "mediaObject" ) );

            //将类QVideoFrameProbe的实例化对象_probe的数据来源设为_camera
            if( _probe.setSource( _camera ) )
            {
                //	链接信号槽，每当_probe有新的一帧数据( frame )来时，使用信号槽将frame发送至槽函数_onProcssFrame 进行想要的处理。
                connect( &_probe, SIGNAL( videoFrameProbed( const QVideoFrame & ) ),
                         this, SLOT( _onProcssFram( const QVideoFrame & ) ) );
            }
        }
        qDebug() << "set Camera success!";
    }
}

void CameraFromQML::_onProcssFram( const QVideoFrame &frame )
{
    //在此处进行想要对每一帧进行的处理
    qDebug() << "here comes the frame from camera";
}
