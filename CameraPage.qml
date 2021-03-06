import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtMultimedia 5.12
import QtQuick.Layouts 1.12
import CameraFromQML 1.0

Page {
    CameraFromQML {
        id: cameraFromQML;
    }
    id: page
    title: "camerapage"
    function getPriateDirectory() {
        var sharepath = "C:/Users/leehuitao/Desktop/123.jpg";
        var path = sharepath ;
        console.log("path: " + path);
        return path;
    }
    function readyreadMsg(str){
        console.log("readyreadMsg str: " + str);
        textShow.text = str
        fadeIn.start()
    }

    Camera {

        id: camera

        imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash

        exposure {
            exposureCompensation: -1.0
            exposureMode: Camera.ExposurePortrait
        }

        flash.mode: Camera.FlashRedEyeReduction

        imageCapture {
            onImageCaptured: {
                console.log("image captured! reqId: " + requestId)
                image.source = preview  // Show the preview in an Image
            }

            onImageSaved: {
                console.log("image has been saved: " + requestId);
                console.log("saved path: " + path);
                image.source = path;
                cameraFromQML.onCaptureImage(path.toString());
                sendImagePath(path.toString());
            }

        }

        Component.onCompleted: {
            resolution = camera.viewfinder.resolution;
            console.log("resolution: " + resolution.width + " " + resolution.height);
        }
    }

    Row {
        id: container
        VideoOutput {
            id: video
            source: camera
            width: page.width
            height: page.height
            focus : visible // to receive focus and capture key events when visible
            orientation: -90
            Text {
                id: textShow
                anchors.centerIn: parent
                anchors.margins: 6
                text: qsTr("yhkj")
                visible: true
                color: "#000000"
                PropertyAnimation
                {
                    id: fadeOut
                    target: textShow
                    duration: 300
                    property: "opacity"
                    from: 1.0
                    to: 0.0

                    onStopped: textShow.visible = false
                }

                PropertyAnimation
                {
                    id: fadeIn
                    target: textShow
                    duration: 300
                    property: "opacity"
                    from: 0.0
                    to: 1.0

                    onStarted: textShow.visible = true
                }
            }

        }

        Item {
            id: view
            width: page.width
            height: page.height

            Image {
                //                    anchors.fill: parent
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: parent.height
                height: parent.width
                id: image
                rotation: 90
                fillMode: Image.PreserveAspectFit

            }

            Text {
                text: image.source
                color:"red"
                font.pixelSize: units.gu(2.5)
                width: page.width
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }


        }
    }

    states: [
        State {
            name: "image"
            PropertyChanges {
                target: container
                x:-page.width
            }
            PropertyChanges {
                target: capture
                opacity:50
                text : "back"
            }
        },
        State {
            name: "back"
            PropertyChanges {
                target: container
                x:0
            }
            PropertyChanges {
                target: capture
                opacity:100
                text : "Capture"
            }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation { target: container; property: "x"; duration: 500
                easing.type:Easing.OutSine}
            //                NumberAnimation { target: inputcontainer; property: "opacity"; duration: 200}
            NumberAnimation { target: capture; property: "opacity"; duration: 200}
        }
    ]
    //?????????C++????????????
    CameraFromQML{
        id: fileter

        //???????????????C++??? CameraFromQML?????? ?????????setQmlCamera( QObject *qmlCamera ) ??????
        qmlCamera: camera
    }


    Button {
        id: capture
        anchors.bottom: parent.bottom
        anchors.bottomMargin: units.gu(1)
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Capture"

        onClicked: {
            if(text == "Capture"){
                console.log("capture path: " + getPriateDirectory());
                camera.imageCapture.captureToLocation("camera.jpg");
                page.state = "image"
            }else{
                page.state = "back"
            }

        }
    }

}
