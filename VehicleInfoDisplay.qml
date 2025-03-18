import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Window

Item
{
    property int vehicleSpeed: 0
    property int rearBrakePres: 0
    property int frontBrakePres: 0
    property string coolantTemp: "-"
    property string oilTemp: "-"
    property string fuelTemp: "-"

    Rectangle
    {
        id: engineInfoScreen

        x: -800
        y: -10

        width: 800
        height: 310
        color: "transparent"
        //visible: false

        Rectangle
        {
            id: spacer

            anchors
            {
                top: engineInfoScreen.top
                bottom: engineInfoScreen.bottom
                left: engineInfoScreen.left
            }

            width: 20
            //height: 280
            color: "transparent"
            visible: false
        }

        Flow
        {
            anchors
            {
                top: engineInfoScreen.top
                bottom: engineInfoScreen.bottom
                left: spacer.right
                right: engineInfoScreen.right
            }

            spacing: 10


            Rectangle
            {
                id: infoWidget1 // rear brake pressure

                width: 375
                height: 150
                radius: 20
                color: "#1E1E1E"

                ProgressBar
                {
                    id: widget1ProgressBar
                    from: 0
                    to: 150
                    value: rearBrakePres
                    anchors.centerIn: infoWidget1

                    background: Rectangle
                    {
                        implicitWidth: 340
                        implicitHeight: 50
                        radius: 5
                        color: "transparent"
                    }

                    contentItem: Item
                    {
                        implicitWidth: 340
                        implicitHeight: 50

                        Rectangle
                        {
                            width: widget1ProgressBar.visualPosition * parent.width
                            height: parent.height
                            radius: 5
                            color: "#00FF00"
                            visible: !widget1ProgressBar.indeterminate
                        }
                    }
                }

                Rectangle
                {
                    id: uselessRectangle2
                    width: 340
                    height: 50
                    border.width: 3
                    border.color: "#E0E0E0"
                    color: "transparent"
                    radius: 5

                    anchors
                    {
                        centerIn: infoWidget1
                    }
                }

                Rectangle
                {
                    anchors
                    {
                        top: infoWidget1.top
                        left: infoWidget1.left
                        margins: 18
                    }

                    Text
                    {
                        id: infoWidget1TextLabel1
                        text: qsTr("0")
                        color: "white"
                        font.pixelSize: 18
                    }
                }

                Rectangle
                {
                    anchors
                    {
                        top: infoWidget1.top
                        left: infoWidget1.left
                        leftMargin: 332
                        topMargin: 18
                        bottomMargin: 18
                    }

                    Text
                    {
                        id: infoWidget1TextLabel2
                        text: qsTr("150")
                        color: "white"
                        font.pixelSize: 18
                    }
                }

                Rectangle
                {
                    id: uselessRectangle3


                    anchors
                    {
                        //top: widget1ProgressBar.bottom
                        top:infoWidget1.top
                        bottom: widget1ProgressBar.top
                        horizontalCenter: uselessRectangle2.horizontalCenter
                        topMargin: 4
                    }

                    Text
                    {
                        id: infoWidget1TextLabel3
                        text: qsTr("Rear Brake Pressure (Bar)")
                        color: "white"
                        font.pixelSize: 18
                        anchors.centerIn: uselessRectangle3
                    }
                }

                Rectangle
                {
                    id: leftProgressBarText


                    anchors
                    {
                        top: widget1ProgressBar.bottom
                        horizontalCenter: uselessRectangle2.horizontalCenter
                        topMargin: 24
                    }

                    Text
                    {
                        id: infoWidget1TextLabel4
                        text: rearBrakePres
                        color: "white"
                        font.pixelSize: 22
                        anchors.centerIn: parent
                    }
                }
            }

            Rectangle
            {
                id: infoWidget2

                width: 375
                height: 150
                radius: 20
                color: "#1E1E1E"

                ProgressBar
                {
                    id: widget2ProgressBar
                    from: 0
                    to: 150
                    value: frontBrakePres
                    anchors.centerIn: infoWidget2

                    background: Rectangle
                    {
                        implicitWidth: 340
                        implicitHeight: 50
                        radius: 5
                        color: "transparent"
                    }

                    contentItem: Item
                    {
                        implicitWidth: 340
                        implicitHeight: 50

                        Rectangle
                        {
                            width: widget2ProgressBar.visualPosition * parent.width
                            height: parent.height
                            radius: 5
                            color: "#00FF00"
                            visible: !widget2ProgressBar.indeterminate
                        }
                    }
                }

                Rectangle
                {
                    id: uselessRectangle4
                    width: 340
                    height: 50
                    border.width: 3
                    border.color: "#E0E0E0"
                    color: "transparent"
                    radius: 5

                    anchors
                    {
                        centerIn: infoWidget2
                    }
                }

                Rectangle
                {
                    anchors
                    {
                        top: infoWidget2.top
                        left: infoWidget2.left
                        margins: 18
                    }

                    Text
                    {
                        id: infoWidget2TextLabel1
                        text: qsTr("0")
                        color: "white"
                        font.pixelSize: 18
                    }
                }

                Rectangle
                {
                    anchors
                    {
                        top: infoWidget2.top
                        left: infoWidget2.left
                        leftMargin: 332
                        topMargin: 18
                        bottomMargin: 18
                    }

                    Text
                    {
                        id: infoWidget2TextLabel2
                        text: qsTr("150")
                        color: "white"
                        font.pixelSize: 18
                    }
                }

                Rectangle
                {
                    id: uselessRectangle5

                    anchors
                    {
                        top:infoWidget2.top
                        bottom: widget2ProgressBar.top
                        horizontalCenter: uselessRectangle4.horizontalCenter
                        topMargin: 4
                    }

                    Text
                    {
                        id: infoWidget2TextLabel3
                        text: qsTr("Front Brake Pressure (Bar)")
                        color: "white"
                        font.pixelSize: 18
                        anchors.centerIn: uselessRectangle5
                    }
                }

                Rectangle
                {
                    id: rightProgressBarText

                    anchors
                    {
                        top: widget2ProgressBar.bottom
                        horizontalCenter: uselessRectangle4.horizontalCenter
                        topMargin: 24
                    }

                    Text
                    {
                        id: infoWidget2TextLabel4
                        text: frontBrakePres
                        color: "white"
                        font.pixelSize: 22
                        anchors.centerIn: parent
                    }
                }
            }

            Rectangle
            {
                id: infoWidget3

                width: 247
                height: 160
                radius: 20
                color: "#1E1E1E"

                Text
                {
                    id: widget3Info

                    text: coolantTemp
                    color: (Number(coolantTemp.slice(0, coolantTemp.length - 2)) > 99) ? "red" : "white"
                    font.pixelSize: 60
                    font.bold: true

                    anchors
                    {
                        top: infoWidget3.top
                        horizontalCenter: infoWidget3.horizontalCenter
                        topMargin: 10
                    }
                }

                Text
                {
                    text: qsTr("Coolant Temp")
                    color: "white"
                    font.pixelSize: 30
                    font.bold: false

                    anchors
                    {
                        horizontalCenter: infoWidget3.horizontalCenter
                        bottom: infoWidget3.bottom
                        bottomMargin: 15
                    }
                }
            }

            Rectangle
            {
                id: infoWidget4

                width: 247
                height: 160
                radius: 20
                color: "#1E1E1E"

                Text
                {
                    id: widget4Info

                    text: oilTemp
                    color: (Number(oilTemp.slice(0, oilTemp.length - 2)) > 99) ? "red" : "white"
                    font.pixelSize: 60
                    font.bold: true

                    anchors
                    {
                        top: infoWidget4.top
                        horizontalCenter: infoWidget4.horizontalCenter
                        topMargin: 10
                    }
                }

                Text
                {
                    text: qsTr("Oil Temp")
                    color: "white"
                    font.pixelSize: 30
                    font.bold: false

                    anchors
                    {
                        horizontalCenter: infoWidget4.horizontalCenter
                        bottom: infoWidget4.bottom
                        bottomMargin: 15
                    }
                }
            }

            Rectangle
            {
                id: infoWidget5

                width: 246
                height: 160
                radius: 20
                color: "#1E1E1E"

                Text
                {
                    id: widget5Info

                    text: fuelTemp
                    color: (Number(fuelTemp.slice(0, fuelTemp.length - 2)) > 99) ? "red" : "white"
                    font.pixelSize: 60
                    font.bold: true

                    anchors
                    {
                        top: infoWidget5.top
                        horizontalCenter: infoWidget5.horizontalCenter
                        topMargin: 10
                    }
                }

                Text
                {
                    text: qsTr("Fuel Temp")
                    color: "white"
                    font.pixelSize: 30
                    font.bold: false

                    anchors
                    {
                        horizontalCenter: infoWidget5.horizontalCenter
                        bottom: infoWidget5.bottom
                        bottomMargin: 15
                    }
                }
            }
        }

    }
}
