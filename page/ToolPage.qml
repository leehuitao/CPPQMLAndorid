import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.3
Page{
    id:toolApi

    Dialog{
        id: dialog_BridgeTool
        title:"dialog_BridgeTool"
        property int type: 0
        width: 400
        height: 100
        standardButtons: StandardButton.Ok|StandardButton.Cancel
        onAccepted: {
            console.log("ok");
            // 选择功能表
            switch(type)
            {
            case 1 :{
                var msg =  bridgeToolapi.loginNetWorkPack(dialog_input_0.text , dialog_input_1.text);
//                console.log("data " , msg);
                var ret = sendMessageHex(msg);
//                console.log("send status : " , ret);
                break;
            }
            case 2 :{
                var msg =  bridgeToolapi.registerNetWorkPack(dialog_input_0.text , dialog_input_1.text , dialog_input_2.text);
//                console.log("d    ata " , msg);
                var ret = sendMessageHex(msg);

//                console.log("send status : " , ret);
                break;
            }
            }
        }


        // 外观
        Column{
            id:cloumn1
            spacing: 5
            Text {
                text: qsTr("通过提示输入参数:")
            }
            Rectangle{
                id:dialog_input_0_bg
                x:100
                width: 200
                height: 30
                color: "#aca9a9"
                visible: false
                Text {
                    x:0 - width
                    id: dialog_input_0_lab
                    text: qsTr("null")
                }
                TextInput{
                    id:dialog_input_0
                    width: parent.width
                    height: parent.height
                }
            }

            Rectangle{
                x:100
                id:dialog_input_1_bg
                width: 200
                height: 30
                color: "#aca9a9"
                visible: false
                Text {
                    x:0 - width
                    id: dialog_input_1_lab
                    text:  qsTr("null")
                }
                TextInput{
                    id:dialog_input_1
                    width: parent.width
                    height: parent.height
                }
            }

            Rectangle{

                id:dialog_input_2_bg
                x:100
                width: 200
                height: 30
                color: "#aca9a9"
                visible:false
                Text {
                    x:0 - width
                    id: dialog_input_2_lab
                    text: qsTr("null")
                }
                TextInput{
                    id:dialog_input_2
                    width: parent.width
                    height: parent.height
                }
            }

            Rectangle{

                id:dialog_input_3_bg
                x:100
                width: 200
                height: 30
                color: "#aca9a9"
                visible: false
                Text {
                    x:0 - width
                    id: dialog_input_3_lab
                    text:  qsTr("null")
                }
                TextInput{
                    id:dialog_input_3
                    width: parent.width
                    height: parent.height
                }
            }

            Rectangle{
                x:100
                id:dialog_input_4_bg
                width: 200
                height: 30
                color: "#aca9a9"
                visible:false
                Text {
                    x:0 - width
                    id: dialog_input_4_lab
                    text:  qsTr("null")
                }
                TextInput{
                    id:dialog_input_4
                    width: parent.width
                    height: parent.height
                }
            }


            Rectangle{
                x:100
                id:dialog_input_5_bg
                width: 200
                height: 30
                color: "#aca9a9"
                visible:false
                Text {
                    x:0 - width
                    id: dialog_input_5_lab
                    text:  qsTr("null")
                }
                TextInput{
                    id:dialog_input_5
                    width: parent.width
                    height: parent.height
                }
            }


        }

        function demofun()
        {
            dialog_input_0.text = "";
            dialog_input_1.text = "";
            dialog_input_2.text = "";
            dialog_input_3.text = "";
            dialog_input_4.text = "";
            dialog_input_5.text = "";

            dialog_input_0_bg.visible = true ;
            dialog_input_0_lab.text = "data1(int) ";

            dialog_input_1_bg.visible = true ;
            dialog_input_1_lab.text = "sessionid(str) ";

            dialog_input_2_bg.visible = true ;
            dialog_input_2_lab.text = "type(int) ";

            dialog_input_3_bg.visible = true ;
            dialog_input_3_lab.text = "beginTime(int) ";

            dialog_input_4_bg.visible = true ;
            dialog_input_4_lab.text = "endTime(int) ";

            dialog_input_5_bg.visible = true ;
            dialog_input_5_lab.text = "direction(int) ";


            visible = true;
        }

        function show_login()
        {
            title="登录用户"
            type = 1 ;
            dialog_input_0.text = "";
            dialog_input_1.text = "";
            dialog_input_2.text = "";
            dialog_input_3.text = "";
            dialog_input_4.text = "";
            dialog_input_5.text = "";

            dialog_input_0_bg.visible = true ;
            dialog_input_0_lab.text = "用户名(str) ";

            dialog_input_1_bg.visible = true ;
            dialog_input_1_lab.text = "密码(str) ";

            dialog_input_2_bg.visible = false ;
            dialog_input_2_lab.text = "";

            dialog_input_3_bg.visible = false ;
            dialog_input_3_lab.text = "";

            dialog_input_4_bg.visible = false ;
            dialog_input_4_lab.text = " ";

            dialog_input_5_bg.visible = false ;
            dialog_input_5_lab.text = " ";

            visible = true;
        }

        function show_register()
        {
            title="注册用户"
            type = 2 ;
            dialog_input_0.text = "";
            dialog_input_1.text = "";
            dialog_input_2.text = "";
            dialog_input_3.text = "";
            dialog_input_4.text = "";
            dialog_input_5.text = "";

            dialog_input_0_bg.visible = true ;
            dialog_input_0_lab.text = "用户名(str) ";

            dialog_input_1_bg.visible = true ;
            dialog_input_1_lab.text = "密码(str) ";

            dialog_input_2_bg.visible = true ;
            dialog_input_2_lab.text = "邮箱(str) ";

            dialog_input_3_bg.visible = false ;
            dialog_input_3_lab.text = "";

            dialog_input_4_bg.visible = false ;
            dialog_input_4_lab.text = " ";

            dialog_input_5_bg.visible = false ;
            dialog_input_5_lab.text = " ";

            visible = true;
        }
    }

    Button {
        id: button
        x: 103
        y: 168
        text: qsTr("Button")
        onClicked: {
//            dialog_BridgeTool.demofun();

            noticeApi.showMessage("test " , "test30")
        }
    }

    Button {
        id: button1
        x: 103
        y: 238
        text: qsTr("登录")
        onClicked: {
            dialog_BridgeTool.show_login();
        }
    }

    Button {
        id: button2
        x: 103
        y: 306
        text: qsTr("注册")
        onClicked: {
            dialog_BridgeTool.show_register();
        }
    }

    Button {
        id: button3
        x: 110
        y: 379
        property bool status_led_1: false
        text: qsTr("Switch1")
        onClicked: {
            status_led_1 =!status_led_1;
            console.log("current : " , status_led_1);
            changeLedStatus(0x01 , status_led_1);
        }
    }

    Button {
        id: button4
        x: 230
        y: 168
        text: qsTr("test1")
        onClicked: {
            var data = 'test data';bridgeToolapi.loginDeviceNetWorkPack("test1");
            console.log("data device : " , data);
        }
    }


}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/











/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
