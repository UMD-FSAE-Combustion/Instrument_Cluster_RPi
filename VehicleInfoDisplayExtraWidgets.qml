import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Window

Item
{
    GridLayout
    {
        id: widgets

        rows: 2
        columns: 3

        rowSpacing: 10
        columnSpacing: 10


        anchors.fill: parent
        anchors.margins: 20


        Rectangle
        {
            id: infoWidget6
            color: "#1E1E1E"
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 20

            Text
            {
                id: widget6Info

                text: qsTr("0")
                color: "white"
                font.pixelSize: 70
                font.bold: true

                anchors
                {
                    top: infoWidget6.top
                    horizontalCenter: infoWidget6.horizontalCenter
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
                    horizontalCenter: infoWidget6.horizontalCenter
                    bottom: infoWidget6.bottom
                    bottomMargin: 15
                }
            }
        }

        Rectangle
        {
            id: infoWidget7
            color: "#1E1E1E"
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 20

            Text
            {
                id: widget7Info

                text: qsTr("0")
                color: "white"
                font.pixelSize: 70
                font.bold: true

                anchors
                {
                    top: infoWidget7.top
                    horizontalCenter: infoWidget7.horizontalCenter
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
                    horizontalCenter: infoWidget7.horizontalCenter
                    bottom: infoWidget7.bottom
                    bottomMargin: 15
                }
            }
        }

        Rectangle
        {
            id: infoWidget8
            color: "#1E1E1E"
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 20

            Text
            {
                id: widget8Info

                text: qsTr("0")
                color: "white"
                font.pixelSize: 70
                font.bold: true

                anchors
                {
                    top: infoWidget8.top
                    horizontalCenter: infoWidget8.horizontalCenter
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
                    horizontalCenter: infoWidget8.horizontalCenter
                    bottom: infoWidget8.bottom
                    bottomMargin: 15
                }
            }
        }

        Rectangle
        {
            id: infoWidget9
            color: "#1E1E1E"
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 20

            Text
            {
                id: widget9Info

                text: qsTr("0")
                color: "white"
                font.pixelSize: 70
                font.bold: true

                anchors
                {
                    top: infoWidget9.top
                    horizontalCenter: infoWidget9.horizontalCenter
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
                    horizontalCenter: infoWidget9.horizontalCenter
                    bottom: infoWidget9.bottom
                    bottomMargin: 15
                }
            }
        }

        Rectangle
        {
            id: infoWidget10
            color: "#1E1E1E"
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 20

            Text
            {
                id: widget10Info

                text: qsTr("0")
                color: "white"
                font.pixelSize: 70
                font.bold: true

                anchors
                {
                    top: infoWidget10.top
                    horizontalCenter: infoWidget10.horizontalCenter
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
                    horizontalCenter: infoWidget10.horizontalCenter
                    bottom: infoWidget10.bottom
                    bottomMargin: 15
                }
            }
        }

        Rectangle
        {
            id: infoWidget11
            color: "#1E1E1E"
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 20

            Text
            {
                id: widget11Info

                text: qsTr("0")
                color: "white"
                font.pixelSize: 70
                font.bold: true

                anchors
                {
                    top: infoWidget11.top
                    horizontalCenter: infoWidget11.horizontalCenter
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
                    horizontalCenter: infoWidget11.horizontalCenter
                    bottom: infoWidget11.bottom
                    bottomMargin: 15
                }
            }
        }
    }
}
