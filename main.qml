import QtQuick 2.4
import QtQuick.Window 2.4
import QtQuick.Controls 2.2
import plugin.backend 1.0
import QtCharts 2.0

Window {
    id:mainWindow
    width: 500
    height: 400
    title: qsTr("HELLO")
    visible: true

    Backend{
        id: backend
        property int index: 0
        property int windowSize: 50
    }
    Column{
    Row {
        width: parent.width
        height: 50
        Label {
            id:label
            width: parent.width/3
            // anchors.left: parent.left
            text: "X:"+backend.accelX.toString()
        }

        Label {
            id:label1
            width: parent.width/3
            // anchors.horizontalCenter: parent.horizontalCenter
            text: "Y:"+backend.accelY.toString()
        }

        Label {
            id:label2
            width: parent.width/3
            // anchors.right: parent.right
            text: "Z:"+backend.accelZ.toString()
        }
    }

    ChartView {
        id:chart
        width: 500
        height: 350
        title: "X axis"
        // animationOptions: ChartView.SeriesAnimations

        ValueAxis {
            id: myAxisX
            min: backend.index-backend.windowSize
            max: backend.windowSize>backend.index? 10:backend.index+1
        }
        ValueAxis {
            id: myAxisY
            min: -2
            max: 2
        }

        LineSeries {
            id: lineDataX
            axisX: myAxisX
            axisY: myAxisY
            width: 3
            color:"#FF0000"
        }
        LineSeries {
            id: lineDataY
            axisX: myAxisX
            axisY: myAxisY
            width: 3
            color:"#00FF00"
        }
        LineSeries {
            id: lineDataZ
            axisX: myAxisX
            axisY: myAxisY
            width: 3
            color:"#0000FF"
        }

        Timer {
            interval: 10
            running: true
            repeat: true
            onTriggered: {
                backend.getImuData()
                backend.index = backend.index + 1
                if(lineDataX.count > backend.windowSize){
                    lineDataX.remove(0)
                    lineDataY.remove(0)
                    lineDataZ.remove(0)
                }
                lineDataX.append(backend.index,backend.accelX)
                lineDataY.append(backend.index,backend.accelY)
                lineDataZ.append(backend.index,backend.accelZ)
            }
        }
    }
    }
}