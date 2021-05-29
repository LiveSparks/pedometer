import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0

Page {
    id: page
    width: 320
    height: 240

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
        x: 0
        y: 0
        width: 320
        height: 46
        source: "Armband_Pi__2_logo.png"
        fillMode: Image.PreserveAspectFit
    }

    RowLayout {
        x: 0
        width: 320
        anchors.top: gridLayout.bottom
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        Button {
            id: exitButton
            text: qsTr("Let's get started!")
            font.bold: true
            font.pointSize: 7
            font.family: "Lato Hairline"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.minimumWidth: 120
            Layout.minimumHeight: 30

            contentItem: Text {
                text: exitButton.text
                font: exitButton.font
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                // font.pointSize: 7
                color: userSettings.gray
            }

            background: Rectangle {
                width: exitButton.width
                height: exitButton.height
                color: exitButton.down ? userSettings.yellow : userSettings.yellow
                border.color: "#ffffff"
                border.width: 2
            }
            // @disable-check M223
            onClicked: {
                // @disable-check M222
                stackView.pop()
            }
        }
    }

    GridLayout {
        id: gridLayout
        width: 254
        height: 135
        anchors.top: armband_Pi__2_logo.bottom
        anchors.topMargin: 5
        rows: 2
        columns: 2
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            id: rectangle
            color: userSettings.gray
            Layout.minimumHeight: 50
            Layout.minimumWidth: 120
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop

            Text {
                id: text1
                color: userSettings.purple
                text: qsTr("Height (cm)")
                anchors.top: parent.top
                font.pixelSize: 9
                anchors.topMargin: 2
                font.family: "Lato"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            SpinBox {
                id: spinBox
                width: 100
                height: 25
                anchors.top: text1.bottom
                wheelEnabled: true
                stepSize: 2
                to: 200
                from: 60
                value: globalSettings.userHeight
                font.pointSize: 8
                font.family: "Lato"
                anchors.topMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter

                // @disable-check M223
                onValueChanged: {
                    globalSettings.userHeight = value
                }
            }
        }

        Rectangle {
            id: rectangle1
            color: userSettings.gray
            Layout.minimumWidth: 120
            Layout.minimumHeight: 50
            Layout.alignment: Qt.AlignRight | Qt.AlignTop
            Text {
                id: text2
                color: userSettings.purple
                text: qsTr("Weight (Kg)")
                anchors.top: parent.top
                font.pixelSize: 9
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Lato"
                anchors.topMargin: 2
            }

            SpinBox {
                id: spinBox1
                width: 100
                height: 25
                anchors.top: text2.bottom
                font.pointSize: 8
                wheelEnabled: true
                value: globalSettings.userWeight
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Lato"
                anchors.topMargin: 5
                stepSize: 1
                to: 200
                from: 30

                // @disable-check M223
                onValueChanged: {
                    globalSettings.userWeight = value
                }
            }
        }

        Rectangle {
            id: rectangle2
            color: userSettings.gray
            Layout.minimumWidth: 120
            Layout.minimumHeight: 50
            Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
            Text {
                id: text3
                color: userSettings.purple
                text: qsTr("Age")
                anchors.top: parent.top
                font.pixelSize: 9
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Lato"
                anchors.topMargin: 2
            }

            SpinBox {
                id: spinBox2
                width: 100
                height: 25
                anchors.top: text3.bottom
                wheelEnabled: true
                font.pointSize: 8
                value: globalSettings.userAge
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Lato"
                anchors.topMargin: 5
                stepSize: 1
                to: 150
                from: 13

                // @disable-check M223
                onValueChanged: {
                    globalSettings.userAge = value
                }
            }
        }

        Rectangle {
            id: rectangle3
            color: userSettings.gray
            Layout.minimumWidth: 120
            Layout.minimumHeight: 50
            Layout.alignment: Qt.AlignRight | Qt.AlignBottom
            Text {
                id: text4
                color: userSettings.purple
                text: qsTr("Sex")
                anchors.top: parent.top
                font.pixelSize: 9
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Lato"
                anchors.topMargin: 2
            }

            ComboBox {
                id: comboBox
                width: 100
                height: 25
                anchors.top: text4.bottom
                font.pointSize: 8
                font.family: "Lato"
                model: ["Male", "Female", "Other"]
                currentIndex: globalSettings.userSex
                anchors.topMargin: 5

                anchors.horizontalCenter: parent.horizontalCenter

                // @disable-check M223
                onCurrentIndexChanged: {
                    globalSettings.userSex = currentIndex
                }
            }
        }
    }
}
