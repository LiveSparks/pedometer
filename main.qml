import QtQuick 2.4
import QtQuick.Window 2.4
import QtQuick.Controls 2.2
import plugin.backend 1.0
import QtCharts 2.0

Window {
    id:mainWindow
    width: 320
    height: 240
    title: qsTr("HELLO")
    visible: true
    visibility: "FullScreen"
    color: "#74C8C1"

    Item {
        id: globalSettings
        property color blue: "#74c8c1"
        property color purple: "#695096"
        property color lightGreen: "#A4D9A7"
        property color garkGreen: "#579D6B"
        property color yellow: "#F4CC59"
        property color brown: "#83544A"
        property color gray: "#F6EAEA"

        property int userHeight: 180
        property int userWeight: 70
        property int userAge: 70
        property int userSex: 0
    }

    Rectangle {
        id: rectangle
        width: parent.width
        height: parent.height
        color: globalSettings.blue
        border.color: "red"
        border.width: 5
    }

    Backend{
        id: backend
        property int index: 0
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "SplashScreen.ui.qml"
        // initialItem: "SettingsScreen.ui.qml"
        // initialItem: "MainScreen.ui.qml"
        // initialItem: "DebugScreen.ui.qml"
    }

    Timer {
        interval: 2000
        running: true
        onTriggered:{
            backend.init()
            // stackView.push("MainScreen.ui.qml")
            stackView.push("DebugScreen.ui.qml")
        }
    }
}