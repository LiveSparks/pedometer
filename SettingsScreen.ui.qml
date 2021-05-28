import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0

Page {
    id: page
    width: 800
    height: 480

    title: qsTr("Page 1")

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
        width: parent.width
        height: parent.height
        color: userSettings.blue
    }

    Image {
        id: armband_Pi__2_logo
        x: 151
        y: 0
        width: 499
        height: 97
        source: "Armband_Pi__2_logo.png"
        fillMode: Image.PreserveAspectFit
    }

    RowLayout {
        x: 0
        y: 386
        width: 800
        height: 94
        Button {
            id: exitButton
            text: qsTr("Let's get started!")
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
                color: userSettings.gray
            }

            background: Rectangle {
                width: exitButton.width
                height: exitButton.height
                color: exitButton.down ? userSettings.yellow : userSettings.yellow
                border.color: "#ffffff"
                border.width: 2
            }

            onClicked:{
                stackView.pop()
            }
        }
    }

    GridLayout {
        id: gridLayout
        x: 122
        y: 103
        width: 636
        height: 271
        rows: 2
        columns: 2
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            id: rectangle
            color: userSettings.gray
            Layout.minimumHeight: 100
            Layout.minimumWidth: 300
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop

            Text {
                id: text1
                color: userSettings.purple
                text: qsTr("Height (cm)")
                anchors.top: parent.top
                font.pixelSize: 18
                anchors.topMargin: 5
                font.family: "Lato"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            SpinBox {
                id: spinBox
                width: 250
                height: 50
                anchors.top: text1.bottom
                wheelEnabled: true
                stepSize: 2
                to: 200
                from: 60
                value: globalSettings.userHeight
                font.pointSize: 15
                font.family: "Lato"
                anchors.topMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter

                onValueChanged:{
                    globalSettings.userHeight = value
                }
            }
        }

        Rectangle {
            id: rectangle1
            color: userSettings.gray
            Layout.minimumWidth: 300
            Layout.minimumHeight: 100
            Layout.alignment: Qt.AlignRight | Qt.AlignTop
            Text {
                id: text2
                color: userSettings.purple
                text: qsTr("Weight (Kg)")
                anchors.top: parent.top
                font.pixelSize: 18
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Lato"
                anchors.topMargin: 5
            }

            SpinBox {
                id: spinBox1
                width: 250
                height: 50
                anchors.top: text2.bottom
                font.pointSize: 15
                wheelEnabled: true
                value: globalSettings.userWeight
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Lato"
                anchors.topMargin: 10
                stepSize: 1
                to: 200
                from: 30

                onValueChanged:{
                    globalSettings.userWeight = value
                }
            }
        }

        Rectangle {
            id: rectangle2
            color: userSettings.gray
            Layout.minimumWidth: 300
            Layout.minimumHeight: 100
            Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
            Text {
                id: text3
                color: userSettings.purple
                text: qsTr("Age")
                anchors.top: parent.top
                font.pixelSize: 18
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Lato"
                anchors.topMargin: 5
            }

            SpinBox {
                id: spinBox2
                width: 250
                height: 50
                anchors.top: text3.bottom
                wheelEnabled: true
                font.pointSize: 15
                value: globalSettings.userAge
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Lato"
                anchors.topMargin: 10
                stepSize: 1
                to: 150
                from: 13

                onValueChanged:{
                    globalSettings.userAge = value
                }
            }
        }

        Rectangle {
            id: rectangle3
            color: userSettings.gray
            Layout.minimumWidth: 300
            Layout.minimumHeight: 100
            Layout.alignment: Qt.AlignRight | Qt.AlignBottom
            Text {
                id: text4
                color: userSettings.purple
                text: qsTr("Sex")
                anchors.top: parent.top
                font.pixelSize: 18
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Lato"
                anchors.topMargin: 5
            }

            ComboBox {
                id: comboBox
                width: 250
                height: 50
                anchors.top: text4.bottom
                font.pointSize: 12
                font.family: "Lato"
                model: ["Male", "Female", "Other"]
                currentIndex: globalSettings.userSex
                anchors.topMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter

                onCurrentIndexChanged:{
                    globalSettings.userSex = currentIndex
                }
            }
        }
    }
}
