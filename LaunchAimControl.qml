import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Window

Item
{
    property int launchAim: JSON.launchAim

    Rectangle
    {
        //id: antilagControlScreen

        anchors.fill: parent

        radius: 20
        color: "#1E1E1E"

        Column
        {
            id: barSliderHolder

            anchors
            {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                topMargin: 20
                bottomMargin: 20
                leftMargin: 15
            }

            Slider
            {
                id: barSlider
                orientation: Qt.Vertical
                width: 30
                height: 410
                from: 10
                to: 1
                value: launchAim
                enabled: false

                background: Rectangle
                {
                    width: 5
                    color: "#FFCB05"
                    border.color: "black"
                    border.width: 3
                    radius: 2
                    anchors.fill: parent
                    anchors.margins: 10
                }

                handle: Rectangle
                {
                    width: 30
                    height: 15
                    radius: 3
                    color: "white"
                    border.color: "black"
                    border.width: 3
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: barSlider.position * (barSlider.height - height)
                }

                Rectangle
                {
                    id: anchorBox
                    width: 80
                    height: 130
                    color: "transparent"

                    anchors
                    {
                        left: parent.left
                        verticalCenter: parent.verticalCenter
                        leftMargin: 110.5
                    }

                    Text
                    {
                        id: launchAimDisplayValue
                        text: launchAim
                        color: "white"
                        font.pixelSize: 40
                        font.bold: true

                        anchors.centerIn: parent
                    }

                    Text
                    {
                        text: "⯅"
                        width: 25
                        font.pixelSize: 25
                        font.bold: true
                        color: "white"
                        anchors
                        {
                            margins: 10
                            top: anchorBox.top
                            horizontalCenter: launchAimDisplayValue.horizontalCenter
                        }
                    }

                    Text
                    {
                        text: "⯆"
                        width: 25
                        font.pixelSize: 25
                        font.bold: true
                        color: "white"
                        anchors
                        {
                            bottom: anchorBox.bottom
                            horizontalCenter:launchAimDisplayValue.horizontalCenter
                        }
                    }
                }
            }
        }
    }

    function updateLaunchAimSetting(profile, launchAimVal) {
        JSON.updateLaunchAim(profile, launchAimVal)
        canManager.updatePayload(2, (JSON.launchAim *3)) // *3 bc motec rotary bullshit

        launchAim = JSON.launchAim
    }

}
