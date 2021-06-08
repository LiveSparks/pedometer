import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

Page {
    id: page
    // anchors.fill: parent
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

    Rectangle {
        id: rectangle4
        color: globalSettings.blue
        anchors.fill: parent
    }

    RowLayout {
        id: rowLayout
        x: 0
        y: 0
        width: parent.width
        height: parent.height * 0.25

        RoundButton {
            id: playButton
            width: 60
            height: 60
            text: "+"
            Layout.preferredHeight: parent.height * 0.4
            Layout.preferredWidth: height
            Layout.leftMargin: 20
            display: AbstractButton.IconOnly
            radius: 30

            icon.source: localSettings.timerRunning ? "pause.png" : "playicon.png"
            icon.color: "white"
            background: Rectangle {
                color: playButton.down ? "#ffff59" : "#f4cc59"
                radius: width / 2
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
            Layout.fillWidth: true
            fillMode: Image.PreserveAspectFit
        }

        RoundButton {
            id: settingsButton
            width: 60
            height: 60
            radius: 30
            text: "+"
            Layout.preferredHeight: parent.height * 0.4
            Layout.preferredWidth: height
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.rightMargin: 20
            icon.color: "#ffffff"
            background: Rectangle {
                color: settingsButton.down ? "#ffff59" : "#f4cc59"
                radius: height / 2
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
        width: parent.width
        height: parent.height * 0.5
        anchors.top: rowLayout.bottom
        spacing: 0
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            id: rectangle
            width: 72
            height: 72
            color: "#00ffffff"
            radius: width/2
            border.color: globalSettings.gray
            border.width: width * 0.07
            Layout.preferredWidth: (parent.width - 25) / 4
            Layout.preferredHeight: width
            Layout.leftMargin: 5
            Layout.margins: 0

            Text {
                id: text1
                width: parent.width * 0.8
                height: parent.height * 0.35
                color: globalSettings.purple
                text: localSettings.cal.toString()
                //                text: "9999"
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 200
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                minimumPixelSize: 10
                fontSizeMode: Text.Fit
                font.bold: true
                font.family: "Lato"
                anchors.verticalCenterOffset: -5
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: text2
                width: parent.width * 0.3
                height: width / 2
                color: globalSettings.purple
                text: qsTr("kcal")
                anchors.top: text1.bottom
                font.pixelSize: 1500
                horizontalAlignment: Text.AlignHCenter
                fontSizeMode: Text.Fit
                font.family: "Lato"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 0
            }
        }

        Rectangle {
            id: rectangle1
            color: "#00ffffff"
            radius: width/2
            border.color: globalSettings.gray
            border.width: width * 0.07
            Layout.preferredHeight: width
            Layout.preferredWidth: (parent.width - 25) / 4
            Layout.margins: 0
            Text {
                id: text3
                width: parent.width * 0.8
                height: parent.height * 0.35
                color: globalSettings.purple
                text: Math.floor(localSettings.runTime / 60).toString()
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 200
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                fontSizeMode: Text.Fit
                anchors.verticalCenterOffset: -5
                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: true
                font.family: "Lato"
            }

            Text {
                id: text4
                width: parent.width * 0.3
                height: width / 2
                color: globalSettings.purple
                text: qsTr("min")
                anchors.top: text3.bottom
                font.pixelSize: 150
                horizontalAlignment: Text.AlignHCenter
                fontSizeMode: Text.Fit
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
            radius: width/2
            border.color: globalSettings.gray
            border.width: width * 0.07
            Layout.preferredHeight: width
            Layout.preferredWidth: (parent.width - 25) / 4
            Layout.margins: 0
            Text {
                id: text5
                width: parent.width * 0.8
                height: parent.height * 0.35
                color: globalSettings.purple
                text: localSettings.distance.toFixed(2).toString()
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 200
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                minimumPixelSize: 10
                fontSizeMode: Text.Fit
                anchors.verticalCenterOffset: -5
                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: true
                font.family: "Lato"
            }

            Text {
                id: text6
                width: parent.width * 0.3
                height: width / 2
                color: globalSettings.purple
                text: qsTr("km")
                anchors.top: text5.bottom
                font.pixelSize: 200
                horizontalAlignment: Text.AlignHCenter
                fontSizeMode: Text.Fit
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
            radius: width/2
            border.color: globalSettings.gray
            border.width: width * 0.07
            Layout.preferredHeight: width
            Layout.preferredWidth: (parent.width - 25) / 4
            Layout.rightMargin: 0
            Layout.margins: 0
            Text {
                id: stepsText
                width: parent.width * 0.8
                height: parent.height * 0.35
                color: globalSettings.purple
                text: localSettings.stepsRun.toString()
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 200
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                minimumPixelSize: 10
                fontSizeMode: Text.Fit
                anchors.verticalCenterOffset: -5
                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: true
                font.family: "Lato"
            }

            Text {
                id: text8
                width: parent.width * 0.3
                height: width / 2
                color: globalSettings.purple
                text: qsTr("steps")
                anchors.top: stepsText.bottom
                font.pixelSize: 1500
                horizontalAlignment: Text.AlignHCenter
                fontSizeMode: Text.Fit
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Lato"
                anchors.topMargin: 0
            }
        }
    }

    RowLayout {
        id: rowLayout2
        width: parent.width
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: rowLayout1.bottom
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 0

        Button {
            id: exitButton
            text: qsTr("See you next time!")
            Layout.preferredWidth: parent.width / 2
            Layout.preferredHeight: parent.height / 2
            Layout.maximumWidth: parent.width / 2
            Layout.maximumHeight: parent.height / 2
            font.bold: true
            font.pointSize: 200
            font.family: "Lato Hairline"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            contentItem: Text {
                text: exitButton.text
                anchors.fill: parent
                font: exitButton.font
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: 5
                anchors.leftMargin: 5
                anchors.bottomMargin: 5
                anchors.topMargin: 5
                // font.pointSize: 200
                minimumPixelSize: 10
                fontSizeMode: Text.Fit
                // font.pointSize: 14
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

    // Timer periodically calls the getImuData() function.
    // Also used to keep track of the Run Time
    // @disable-check M221
    Timer {
        id: imuTimer
        interval: 20
        running: localSettings.timerRunning
        repeat: true
        property int ticks: 0
        // @disable-check M223
        onTriggered: {
            // @disable-check M222
            backend.getImuData()
            ticks = ticks + 1
        }
    }
}
