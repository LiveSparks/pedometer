import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

Page {
    id: page
    width: 320
    height: 240
    Item {
        id: localSettings
        property bool timerRunning: false
        property int stepsRun: 0
        property int lastSteps: 0
        property int totalSteps: backend.stepCount <= 0 ? 0 : backend.stepCount
        property real distance: stepsRun <= 0 ? 0 : stepsRun * globalSettings.userHeight
                                                / 3 / 100 / 1000
        property int runTime: imuTimer.interval * imuTimer.ticks / 1000
        property int cal: runTime == 0 ? 0 : distance / runTime * globalSettings.userWeight / 800
        // @disable-check M223
        onTotalStepsChanged: {
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
        height: 61

        RoundButton {
            id: playButton
            width: 60
            height: 60
            text: "+"
            Layout.leftMargin: 20
            Layout.preferredHeight: 24
            Layout.preferredWidth: 24
            display: AbstractButton.IconOnly
            radius: 30

            icon.source: localSettings.timerRunning ? "pause.png" : "playicon.png"
            icon.color: "white"
            background: Rectangle {
                color: playButton.down ? "#ffff59" : "#f4cc59"
                radius: 30
            }
            // @disable-check M223
            onClicked: {
                localSettings.timerRunning = localSettings.timerRunning ? false : true
            }
        }

        Image {
            id: image
            width: 163
            height: parent.height
            source: "Armband_Pi__2_logo.png"
            Layout.preferredWidth: 163
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
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.rightMargin: 20
            Layout.preferredHeight: 24
            Layout.preferredWidth: 24
            icon.color: "#ffffff"
            background: Rectangle {
                color: settingsButton.down ? "#ffff59" : "#f4cc59"
                radius: 30
            }
            icon.source: "gear.png"
            display: AbstractButton.IconOnly
            // @disable-check M223
            onClicked: {
                // @disable-check M222
                stackView.push("SettingsScreen.ui.qml")
            }
        }
    }

    RowLayout {
        id: rowLayout1
        x: 0
        width: 320
        height: 108
        anchors.top: rowLayout.bottom
        spacing: 0
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            id: rectangle
            width: 72
            height: 72
            color: "#00ffffff"
            radius: 90
            border.color: globalSettings.gray
            border.width: 5
            Layout.preferredHeight: 72
            Layout.preferredWidth: 72
            Layout.leftMargin: 5
            Layout.margins: 0

            Text {
                id: text1
                width: 70
                height: 25
                color: globalSettings.purple
                text: localSettings.cal.toString()
                //                text: "9999"
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                font.family: "Lato"
                anchors.verticalCenterOffset: -5
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: text2
                color: globalSettings.purple
                text: qsTr("kcal")
                anchors.top: text1.bottom
                font.pixelSize: 15
                font.family: "Lato"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 0
            }
        }

        Rectangle {
            id: rectangle1
            width: 72
            height: 72
            color: "#00ffffff"
            radius: 90
            border.color: globalSettings.gray
            border.width: 5
            Layout.preferredHeight: 72
            Layout.preferredWidth: 72
            Layout.margins: 0
            Text {
                id: text3
                width: 70
                height: 25
                color: globalSettings.purple
                text: Math.floor(localSettings.runTime / 60).toString()
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenterOffset: -5
                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: true
                font.family: "Lato"
            }

            Text {
                id: text4
                color: globalSettings.purple
                text: qsTr("min")
                anchors.top: text3.bottom
                font.pixelSize: 15
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Lato"
                anchors.topMargin: 0
            }
        }

        Rectangle {
            id: rectangle2
            width: 180
            height: 180
            color: "#00ffffff"
            radius: 90
            border.color: globalSettings.gray
            border.width: 5
            Layout.preferredHeight: 72
            Layout.preferredWidth: 72
            Layout.margins: 0
            Text {
                id: text5
                width: 70
                height: 25
                color: globalSettings.purple
                text: localSettings.distance.toFixed(2).toString()
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenterOffset: -5
                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: true
                font.family: "Lato"
            }

            Text {
                id: text6
                color: globalSettings.purple
                text: qsTr("km")
                anchors.top: text5.bottom
                font.pixelSize: 15
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Lato"
                anchors.topMargin: 0
            }
        }

        Rectangle {
            id: rectangle3
            width: 180
            height: 180
            color: "#00ffffff"
            radius: 90
            border.color: globalSettings.gray
            border.width: 5
            Layout.preferredHeight: 72
            Layout.preferredWidth: 72
            Layout.rightMargin: 0
            Layout.margins: 0
            Text {
                id: stepsText
                width: 70
                height: 25
                color: globalSettings.purple
                text: localSettings.stepsRun.toString()
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenterOffset: -5
                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: true
                font.family: "Lato"
            }

            Text {
                id: text8
                color: globalSettings.purple
                text: qsTr("steps")
                anchors.top: stepsText.bottom
                font.pixelSize: 15
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Lato"
                anchors.topMargin: 0
            }
        }
    }

    RowLayout {
        id: rowLayout2
        x: 0
        width: 320
        anchors.top: rowLayout1.bottom
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.topMargin: 0

        Button {
            id: exitButton
            text: qsTr("See you next time!")
            font.bold: true
            font.pointSize: 19
            font.family: "Lato Hairline"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.minimumWidth: 120
            Layout.minimumHeight: 30

            contentItem: Text {
                text: exitButton.text
                font: exitButton.font
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                // font.pointSize: 14
                minimumPixelSize: 12
                color: globalSettings.gray
            }

            background: Rectangle {
                width: exitButton.width
                height: exitButton.height
                color: exitButton.down ? globalSettings.purple : globalSettings.purple
                border.color: "#ffffff"
                border.width: 2
            }
            // @disable-check M223
            onClicked: {
                // @disable-check M222
                backend.shutdown()
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
