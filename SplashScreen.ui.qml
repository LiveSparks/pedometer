import QtQuick 2.4
import QtQuick.Controls 2.2

Page {
    // anchors.fill: parent

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
            anchors.fill: parent
            source: "run.gif"
            fillMode: Image.PreserveAspectFit
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
