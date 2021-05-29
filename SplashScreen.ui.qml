import QtQuick 2.4
import QtQuick.Controls 2.2

Page {
    width: 800
    height: 480

    title: qsTr("Page 2")

    Item {
        id: userSettings
        property color blue: "#74c8c1"
        property color purple: "#695096"
        property color lightGreen: "#A4D9A7"
        property color garkGreen: "#579D6B"
        property color yellow: "#F4CC59"
        property color brown: "#83544A"
        property color gray: "#F6EAEA"
    }

    Rectangle {
        id: rectangle
        width: parent.width
        height: parent.height
        color: userSettings.blue

        AnimatedImage {
            id: animatedImage
            x: 0
            y: 0
            width: 320
            height: 240
            anchors.verticalCenter: parent.verticalCenter
            source: "run.gif"
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
