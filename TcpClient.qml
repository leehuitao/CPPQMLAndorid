import QtQuick 2.12
import QtQuick.Controls 2.12
import TcpClient 1.0
import QtQuick.Window 2.12
import QtMultimedia 5.12
import QtQuick.Layouts 1.12

Page{
    id:tcpclient

    TcpClient{
            id:tcpsocket;
        }

    function sendMessageHex(msg)
    {
        return tcpsocket.sendHexMessage(msg);
    }

    function sendImagePath(path)
    {
        return tcpsocket.sendImagePath(path);
    }
    header: ToolBar{
        RowLayout{
            anchors.fill: parent
            Text{
                text: qsTr("TCP")
                font.pointSize: 20
                horizontalAlignment: Qt.AlignHCenter
                Layout.fillWidth: true
            }
        }
    }

    GridLayout{
        anchors.centerIn: parent
        rows:5;
        rowSpacing: 5;
        columns: 2;
        columnSpacing: 5;

        Text {
            text: qsTr("目的地址：")
            font.bold: true
            Layout.alignment:Qt.AlignCenter
        }
        TextField{
            id:host;
            Layout.preferredWidth: 200
            text: "192.168.101.145"
        }

        Text {
            text: qsTr("端口号：")
            font.bold:true
            Layout.alignment:Qt.AlignCenter
        }
        TextField{
            id:port;
            Layout.preferredWidth: 200
            text: "12345"
        }

        Button{
            text: qsTr("连接状态");
            Layout.alignment:Qt.AlignCenter
            highlighted: true
            onClicked: {
                tcpsocket.connect(host.text,port.text)
            }
        }
        Text {
            id: state
            Layout.alignment: Qt.AlignCenter
            text: "Not connected";

        }
        Button{
            text: qsTr("接收数据");
            Layout.alignment:Qt.AlignCenter
            highlighted: true
        }
        Text {
            id: recivedText
            Layout.alignment: Qt.AlignCenter

        }
        Button{
            text:qsTr("发送")
            Layout.alignment:Qt.AlignCenter
            highlighted: true
            onClicked: {
                if(tcpsocket.sendMessage(send.text))
                {
                    state.text="Sended!"
                }
                else
                {
                    state.text="Send Error!"
                }
            }
        }
        TextField {
            id: send
            Layout.preferredWidth: 200
        }
        Button{
            text:qsTr("断开链接");
            Layout.alignment:Qt.AlignCenter
            highlighted: true
            onClicked: {
                tcpsocket.closeconnect();
            }
        }
        Text {
            id:receive
            width: 100
            clip: true
        }
    }

    Connections {
        target: tcpsocket;
        onConnectStatus:{
            if (type == 1 )
            {
                state.text="Connected Success!"
            }else
            {
                state.text="Connected close!"
            }
        }
        onReadable:{
            console.warn("ui do read ");
            var text=tcpsocket.receiveMesage();
            recivedText.text = text;
            readyreadMsg(text);
            console.log("tecv : " , text)
            tcpsocket.procMesage(text);
        }

        onNoticeMsg:{
            noticeApi.showMessage(title , body)
        }

    }
}
