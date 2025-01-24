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

        rowSpacing: 20
        columnSpacing: 20


        anchors.fill: parent
        anchors.margins: 20


        Rectangle
        {
            id: widget1
            color: "#1E1E1E"
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 10
        }

        Rectangle
        {
            id: widget2
            color: "#1E1E1E"
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 10
        }

        Rectangle
        {
            id: widget3
            color: "#1E1E1E"
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 10
        }

        Rectangle
        {
            id: widget4
            color: "#1E1E1E"
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 10
        }

        Rectangle
        {
            id: widget5
            color: "#1E1E1E"
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 10
        }

        Rectangle
        {
            id: widget6
            color: "#1E1E1E"
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 10
        }
    }
}
