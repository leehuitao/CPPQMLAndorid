import QtQuick 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    minimumHeight: 400
    minimumWidth: 400
    title: qsTr("Tabs")

    function sendMessageHex(msg)
    {
        return tcpclient.sendMessageHex(msg);
    }

    function changeLedStatus(id , status)
    {
        testDevice.changeLed(id , status)
    }

    function sendImagePath(path)
    {
        return tcpclient.sendImagePath(path);
    }
    function readyreadMsg(str)
    {
        cameraPage.readyreadMsg(str);
    }
    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        CameraPage {
            id: cameraPage
        }

        TcpClient {
            id:tcpclient
        }

    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("相机")
        }

        TabButton {
            text: qsTr("TCP")
        }


    }

    Notice{
        id:noticeApi
    }
}
