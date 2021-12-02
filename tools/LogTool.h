#ifndef LOGTOOL_H
#define LOGTOOL_H

#include <QObject>

class LogTool : public QObject
{
    Q_OBJECT
public:
    explicit LogTool(QObject *parent = nullptr);

    void installMessageHandler();
    QString logPath();
    void uninstallMessageHandler();
    QString logName();

    ~LogTool();

    class GC{
    public:
        ~GC();
    };
    static LogTool *Instance();
    static LogTool *self;
signals:
    void sigDebugStrData(QString msg);
public slots:
};

#endif // LOGTOOL_H
