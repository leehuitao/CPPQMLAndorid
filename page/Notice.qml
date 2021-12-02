import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.13
import Qt.labs.platform 1.1


SystemTrayIcon {

    visible: true
    iconSource: "qrc:/icon/geejoan.svg"

    menu: Menu {
        MenuItem {
            text: qsTr("Quit")
            onTriggered: Qt.quit()
        }
        MenuItem{
            text: qsTr("Test")
            onTriggered: {
                console.log("Test")
            }
        }
    }
    onMessageClicked: console.log("init")
    Component.onCompleted: showMessage("test init ", "test body.")
}
