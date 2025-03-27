import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Window

Item
{
    property int antiLag: JSON.antiLag

    Rectangle
    {
        id: antiLagRoot

        anchors.fill: parent

        radius: 20
        color: "#1E1E1E"

        Rectangle {
            id: backgroundColor
            width:  250
            height:  178

            anchors {
                bottom: carTurbo.bottom
                top: carTurbo.top
                left: carTurbo.left
                right: carTurbo.right
            }

            color {
                r:  if(antiLag > 5) { ((255 - (51 * antiLag)) / 255) }
                    else { 1 }

                g:  if(antiLag < 5) { ((51* antiLag) / 255) }
                    else { 1 }

                b: 0
                a: 1
            }
        }

        Image
        {
            id: carTurbo
            anchors
            {
                top: parent.top
                right: parent.right
                topMargin: 115
                rightMargin: 12
            }

            width: 250
            height: 178
            source: "assets/images/car-turbocharger.png"
        }



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
                value: antiLag
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

                    Rectangle {
                        id: displayValBkgrnd2
                        color: "#4b4b4b"
                        border.color: "#3d3d3d"
                        border.width: 3
                        anchors.centerIn: antiLagDisplayValue
                        width: 163
                        height: 53
                        radius: 20
                    }

                    Text
                    {
                        id: antiLagDisplayValue
                        text: antiLag
                        color: "white"
                        font.pixelSize: 40
                        font.bold: true

                        anchors{
                            horizontalCenter: parent.horizontalCenter
                            top: parent.top
                            topMargin: -125
                        }
                    }
                }
            }
        }
    }

    function updateAntiLagSetting(profile, antiLagVal) {
        JSON.updateAntiLag(profile, antiLagVal)
        canManager.updatePayload(3, (JSON.antiLag *3)) // *3 bc motec rotary bullshit

        antiLag = JSON.antiLag
    }
}
