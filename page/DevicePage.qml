import QtQuick 2.12
import QtQuick.Controls 2.5

Page{
    id:testDevice
    property bool key_led_1: false
    property bool key_led_2: false
    property bool key_led_3: false
    property bool key_led_4: false

    function changeLed(id , status)
    {
        if((id & 0x01) == 0x01 )
        {
            key_led_1 = status;
        }

        if((id & 0x02) == 0x02 )
        {
            key_led_2 = status;
        }

        if((id & 0x04) == 0x04 )
        {
            key_led_3 = status;
        }

        if((id & 0x08) == 0x08 )
        {
            key_led_4 = status;
        }
    }

    Grid {
        id: grid
        x: 0
        y: 0
        width: parent.width
        height:parent.height
        spacing: 4
        rows: 2
        columns: 2

        Rectangle{
            width: parent.width/2
            height: parent.height/2
            //            color: "#c7afaf"
            Image {
                id: led1
                width: parent.width *0.6
                height: width
                x:parent.width/2 - width/2
                y : parent.height/2 - height/2
                source:key_led_1? "qrc:/icon/LED_ON.svg":"qrc:/icon/LED_OFF.svg"
            }

        }

        Rectangle{
            width: parent.width/2
            height: parent.height/2
            //            color: "#c7afaf"

            Image {
                id: led2

                width: parent.width *0.6
                height: width
                x:parent.width/2 - width/2
                y : parent.height/2 - height/2
                source:key_led_2? "qrc:/icon/LED_ON.svg":"qrc:/icon/LED_OFF.svg"
            }
        }

        Rectangle{
            width: parent.width/2
            height: parent.height/2
            //            color: "#c7afaf"
            Image {
                id: led3
                width: parent.width *0.6
                height: width
                x:parent.width/2 - width/2
                y : parent.height/2 - height/2
                source:key_led_3? "qrc:/icon/LED_ON.svg":"qrc:/icon/LED_OFF.svg"
            }
        }

        Rectangle{
            width: parent.width/2
            height: parent.height/2
            //            color: "#c7afaf"
            Image {
                id: led4
                width: parent.width *0.6
                height: width
                x:parent.width/2 - width/2
                y : parent.height/2 - height/2
                source:key_led_4? "qrc:/icon/LED_ON.svg":"qrc:/icon/LED_OFF.svg"
            }
        }
    }
}











/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
