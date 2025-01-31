import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Window

Item
{
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
                id: infoWidget1

                width: 375
                height: 150
                radius: 20
                color: "#1E1E1E"
                border.width: 3
                border.color: (root.counter === 9) ? "#00a8ff" : "#1E1E1E"

                ProgressBar
                {
                    id: widget1ProgressBar
                    from: 0
                    to: 100
                    value: 3
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
                        text: qsTr("Text Label")
                        color: "white"
                        font.pixelSize: 13
                    }
                }

                Rectangle
                {
                    anchors
                    {
                        top: infoWidget1.top
                        left: infoWidget1.left
                        leftMargin: 301
                        topMargin: 18
                        rightMargin: 18
                        bottomMargin: 18
                    }

                    Text
                    {
                        id: infoWidget1TextLabel2
                        text: qsTr("Text Label")
                        color: "white"
                        font.pixelSize: 13
                    }
                }

                Rectangle
                {
                    id: uselessRectangle3


                    anchors
                    {
                        top: widget1ProgressBar.bottom
                        horizontalCenter: uselessRectangle2.horizontalCenter
                        topMargin: 18
                    }

                    Text
                    {
                        id: infoWidget1TextLabel3
                        text: qsTr("Text Label")
                        color: "white"
                        font.pixelSize: 13
                        anchors.centerIn: uselessRectangle3
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
                border.width: 3
                border.color: (root.counter === 10) ? "#00a8ff" : "#1E1E1E"

                ProgressBar
                {
                    id: widget2ProgressBar
                    from: 0
                    to: 100
                    value: 3
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
                        text: qsTr("Text Label")
                        color: "white"
                        font.pixelSize: 13
                    }
                }

                Rectangle
                {
                    anchors
                    {
                        top: infoWidget2.top
                        left: infoWidget2.left
                        leftMargin: 301
                        topMargin: 18
                        rightMargin: 18
                        bottomMargin: 18
                    }

                    Text
                    {
                        id: infoWidget2TextLabel2
                        text: qsTr("Text Label")
                        color: "white"
                        font.pixelSize: 13
                    }
                }

                Rectangle
                {
                    id: uselessRectangle5


                    anchors
                    {
                        top: widget2ProgressBar.bottom
                        horizontalCenter: uselessRectangle4.horizontalCenter
                        topMargin: 18
                    }

                    Text
                    {
                        id: infoWidget2TextLabel3
                        text: qsTr("Text Label")
                        color: "white"
                        font.pixelSize: 13
                        anchors.centerIn: uselessRectangle5
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
                border.width: 3
                border.color: (root.counter === 11) ? "#00a8ff" : "#1E1E1E"

                Text
                {
                    id: widget3Info

                    text: qsTr("0")
                    color: "white"
                    font.pixelSize: 70
                    font.bold: true

                    anchors
                    {
                        top: infoWidget3.top
                        horizontalCenter: infoWidget3.horizontalCenter
                        margins: 3
                    }
                }

                Text
                {
                    text: qsTr("-")
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
                border.width: 3
                border.color: (root.counter === 12) ? "#00a8ff" : "#1E1E1E"

                Text
                {
                    id: widget4Info

                    text: qsTr("0")
                    color: "white"
                    font.pixelSize: 70
                    font.bold: true

                    anchors
                    {
                        top: infoWidget4.top
                        horizontalCenter: infoWidget4.horizontalCenter
                        margins: 3
                    }
                }

                Text
                {
                    text: qsTr("-")
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
                border.width: 3
                border.color: (root.counter === 13) ? "#00a8ff" : "#1E1E1E"

                Text
                {
                    id: widget5Info

                    text: qsTr("0")
                    color: "white"
                    font.pixelSize: 70
                    font.bold: true

                    anchors
                    {
                        top: infoWidget5.top
                        horizontalCenter: infoWidget5.horizontalCenter
                        margins: 3
                    }
                }

                Text
                {
                    text: qsTr("-")
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
