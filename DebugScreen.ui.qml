import QtQuick 2.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0
import QtCharts 2.0

Page {
    width: 320
    height: 240

    title: qsTr("Home")

    Row{
        // anchors.fill: parent
        width: mainWindow.width
        height: mainWindow.height
        Column {
            width: parent.width/3
            height: parent.height

            Label {
                text: "Graph Size: "+graphSize.value
            }
            Slider {
                id: graphSize
                from: 10
                to: 200
                value: 50
                stepSize: 10
                width: parent.width
            }

            Row{
                CheckBox{
                    id: checkX
                    checked: true
                }
                Label {
                    text: "X:"+backend.accelX.toFixed(4).toString()
                }
            }

            Row{
                CheckBox{
                    id: checkY
                    checked: true
                }
                Label {
                    text: "Y:"+backend.accelY.toFixed(4).toString()
                }
            }

            Row{
                CheckBox{
                    id: checkZ
                    checked: true
                }
                Label {
                    text: "Z:"+backend.accelZ.toFixed(4).toString()
                }
            }

            Row{
                CheckBox{
                    id: checkM
                    checked: true
                }
                Label {
                    text: "M:"+backend.accelM.toFixed(4).toString()
                }
            }

            Row{
                CheckBox{
                    id: checkL
                    checked: true
                }
                Label {
                    text: "L:"+backend.accelL.toFixed(4).toString()
                }
            }

            Row{
                CheckBox{
                    id: checkH
                    checked: true
                }
                Label {
                    text: "H:"+backend.accelH.toFixed(4).toString()
                }
            }

            Row{
                CheckBox{
                    id: checkC
                    checked: true
                }
                Label {
                    text: "C:"+backend.accelC.toFixed(4).toString()
                }
            }
            

            Label {
                text: "Sample Rate:"+backend.sampleRate.toString()
            }

            Label {
                text: "Step Sensitivity: " + backend.stepSensitivity.toFixed(4).toString()
            }

            Slider {
                id: sensitivitySlider
                from: 0.00
                to: 0.40
                stepSize: 0.01
                value: 0.10
                onValueChanged:{
                    backend.stepSensitivity = value
                }
            }

            Label {
                text: "Steps: " + backend.stepCount.toString()
            }
        }

        Column{
            width:parent.width*2/3
            height: parent.height

            Label {
                text: "Graph Range: "+graphRange.first.value.toFixed(1)+"::"+graphRange.second.value.toFixed(1)
            }
            RangeSlider {
                id: graphRange
                from: -2.0
                to:2.0
                first.value:-0.2
                second.value:0.2
                stepSize: 0.1
                width: parent.width
            }

            ChartView {
                id:chart
                width: parent.width
                height:parent.height - graphRange.height/2 - graphRange.y

                ValueAxis {
                    id: myAxisX
                    min: backend.index-graphSize.value
                    max: graphSize.value>backend.index? 10:backend.index+1
                }
                ValueAxis {
                    id: myAxisY
                    min: graphRange.first.value
                    max: graphRange.second.value
                }

                LineSeries {
                    id: lineDataX
                    name: "X"
                    axisX: myAxisX
                    axisY: myAxisY
                    width: 3
                    color:"red"
                    visible: checkX.checked
                }
                LineSeries {
                    id: lineDataY
                    name: "Y"
                    axisX: myAxisX
                    axisY: myAxisY
                    width: 3
                    color:"blue"
                    visible: checkY.checked
                }
                LineSeries {
                    id: lineDataZ
                    name: "Z"
                    axisX: myAxisX
                    axisY: myAxisY
                    width: 3
                    color:"green"
                    visible: checkZ.checked
                }
                LineSeries {
                    id: lineDataM
                    name: "M"
                    axisX: myAxisX
                    axisY: myAxisY
                    width: 3
                    color:"cyan"
                    visible: checkM.checked
                }
                LineSeries {
                    id: lineDataL
                    name: "L"
                    axisX: myAxisX
                    axisY: myAxisY
                    width: 3
                    color:"yellow"
                    visible: checkL.checked
                }
                LineSeries {
                    id: lineDataH
                    name: "H"
                    axisX: myAxisX
                    axisY: myAxisY
                    width: 3
                    color:"lime"
                    visible: checkH.checked
                }
                LineSeries {
                    id: lineDataC
                    name: "C"
                    axisX: myAxisX
                    axisY: myAxisY
                    width: 3
                    color:"magenta"
                    visible: checkC.checked
                }

                Timer {
                    id: imuTimer
                    interval: 8
                    running: true
                    repeat: true
                    onTriggered: {
                        backend.getImuData()
                        backend.index = backend.index + 1
                        if(lineDataX.count > graphSize.value){
                            lineDataX.remove(0)
                            lineDataY.remove(0)
                            lineDataZ.remove(0)
                            lineDataM.remove(0)
                            lineDataL.remove(0)
                            lineDataH.remove(0)
                            lineDataC.remove(0)
                        }
                        lineDataX.append(backend.index,backend.accelX)
                        lineDataY.append(backend.index,backend.accelY)
                        lineDataZ.append(backend.index,backend.accelZ)
                        lineDataM.append(backend.index,backend.accelM)
                        lineDataL.append(backend.index,backend.accelL)
                        lineDataH.append(backend.index,backend.accelH)
                        lineDataC.append(backend.index,backend.accelC)
                    }
                }
            }
        }
    }

}