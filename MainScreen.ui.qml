import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

Page {

    Item {
        id: localSettings
        property bool timerRunning: false
        property int stepsRun: 0
        property int lastSteps: 0
        property int totalSteps: backend.stepCount <= 0 ? 0: backend.stepCount
        property real distance: stepsRun <=0 ? 0:stepsRun * globalSettings.userHeight/3/100/1000
        property int runTime: imuTimer.interval * imuTimer.ticks /1000
        property int cal: runTime == 0? 0:distance/runTime * globalSettings.userWeight / 800

        onTotalStepsChanged:{
            stepsRun = stepsRun + backend.stepCount - lastSteps
            lastSteps = backend.stepCount
        }
    }

    // onStepCountChanged:{
    //     stepsRun = stepsRun + backend.stepCount - lastSteps
    //     lastSteps = backend.stepCount
    // }

    Rectangle {
        id: rectangle4
        color: globalSettings.blue
        anchors.fill: parent
        // border.color: "red"
        // border.width: 5
    }

    RowLayout {
        id: rowLayout
        x: 0
        y: 0
        width: parent.width
        height: 123

        RoundButton {
            id: playButton
            width: 60
            height: 60
            text: "+"
            Layout.leftMargin: 50
            Layout.preferredHeight: 60
            Layout.preferredWidth: 60
            display: AbstractButton.IconOnly
            radius: 30

            icon.source: localSettings.timerRunning? "pause.png":"playicon.png"
            icon.color: "white"
            background: Rectangle {
                color: playButton.down ? "#ffff59" : "#f4cc59"
                radius: 30
            }

            onClicked:{
                localSettings.timerRunning = localSettings.timerRunning ? false:true
            }
        }

        Image {
            id: image
            width: 538
            height: parent.height
            source: "Armband_Pi__2_logo.png"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: false
            fillMode: Image.PreserveAspectFit
        }

        RoundButton {
            id: settingsButton
            width: 60
            height: 60
            radius: 30
            text: "+"
            Layout.rightMargin: 50
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.preferredHeight: 60
            Layout.preferredWidth: 60
            icon.color: "#ffffff"
            background: Rectangle {
                color: settingsButton.down ? "#ffff59" : "#f4cc59"
                radius: 30
            }
            icon.source: "gear.png"
            display: AbstractButton.IconOnly

            onClicked:{
                stackView.push("SettingsScreen.ui.qml")
            }
        }
    }

    RowLayout {
        id: rowLayout1
        x: 0
        y: 129
        width: parent.width
        height: 219
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            id: rectangle
            width: 180
            height: 180
            color: "#00ffffff"
            radius: 90
            border.color: globalSettings.gray
            border.width: 21
            Layout.leftMargin: 10
            Layout.margins: 5

            Text {
                id: text1
                width: 122
                height: 40
                color: globalSettings.purple
                text: localSettings.cal.toString()
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                font.family: "Lato"
                anchors.verticalCenterOffset: -11
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: text2
                color: globalSettings.purple
                text: qsTr("kcal")
                anchors.top: text1.bottom
                font.pixelSize: 21
                font.family: "Lato"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 10
            }
        }

        Rectangle {
            id: rectangle1
            width: 180
            height: 180
            color: "#00ffffff"
            radius: 90
            border.color: globalSettings.gray
            border.width: 21
            Layout.margins: 5
            Text {
                id: text3
                width: 122
                height: 40
                color: globalSettings.purple
                text: Math.floor(localSettings.runTime/60).toString()
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenterOffset: -11
                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: true
                font.family: "Lato"
            }

            Text {
                id: text4
                color: globalSettings.purple
                text: qsTr("min")
                anchors.top: text3.bottom
                font.pixelSize: 21
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Lato"
                anchors.topMargin: 10
            }
        }

        Rectangle {
            id: rectangle2
            width: 180
            height: 180
            color: "#00ffffff"
            radius: 90
            border.color: globalSettings.gray
            border.width: 21
            Layout.margins: 5
            Text {
                id: text5
                width: 122
                height: 40
                color: globalSettings.purple
                text: localSettings.distance.toFixed(2).toString()
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenterOffset: -11
                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: true
                font.family: "Lato"
            }

            Text {
                id: text6
                color: globalSettings.purple
                text: qsTr("km")
                anchors.top: text5.bottom
                font.pixelSize: 21
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Lato"
                anchors.topMargin: 10
            }
        }

        Rectangle {
            id: rectangle3
            width: 180
            height: 180
            color: "#00ffffff"
            radius: 90
            border.color: globalSettings.gray
            border.width: 21
            Layout.rightMargin: 10
            Layout.margins: 5
            Text {
                id: stepsText
                width: 122
                height: 40
                color: globalSettings.purple
                text: localSettings.stepsRun.toString()
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenterOffset: -11
                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: true
                font.family: "Lato"
            }

            Text {
                id: text8
                color: globalSettings.purple
                text: qsTr("steps")
                anchors.top: stepsText.bottom
                font.pixelSize: 21
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Lato"
                anchors.topMargin: 10
            }
        }
    }

    RowLayout {
        id: rowLayout2
        x: 0
        y: 354
        width: 800
        height: 126

        Button {
            id: exitButton
            text: qsTr("See you next time!")
            font.bold: true
            font.pointSize: 19
            font.family: "Lato Hairline"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.minimumWidth: 300
            Layout.minimumHeight: 60

            contentItem: Text {
                text: exitButton.text
                font: exitButton.font
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: globalSettings.gray
            }

            background: Rectangle {
                width: exitButton.width
                height: exitButton.height
                color: exitButton.down ? globalSettings.purple : globalSettings.purple
                border.color: "#ffffff"
                border.width: 2
            }

            onClicked:{
                backend.shutdown();
            }
        }
    }

    Timer {
        id: imuTimer
        interval: 20
        running: localSettings.timerRunning
        repeat: true
        property int ticks: 0
        onTriggered: {
            backend.getImuData()
            ticks = ticks + 1
        }
    }
}
