import QtQuick
import QtQuick.Layouts

Item {

    property int xPos: parent.x

    id: optMenuRoot

    Text
    {
        text: "⯅"
        width: 20
        font.pixelSize: 20
        font.bold: true
        color: "#4b4b4b"
        anchors
        {
            top: optMenuRoot.top
            horizontalCenter: parent.horizontalCenter
        }
    }

    Text
    {
        text: "⯆"
        width: 20
        font.pixelSize: 20
        font.bold: true
        color: "#4b4b4b"
        anchors
        {
            margins: -5
            bottom: optMenuRoot.bottom
            horizontalCenter: parent.horizontalCenter
        }
    }

    Loader
    {
        id: menuLoader
        anchors.fill:parent

        sourceComponent:
        {
            if(rootWindow.currentSet === 1)
            {
                set1Component
            }
            else if (rootWindow.currentSet === 2)
            {
                set2Component
            }
            else if (rootWindow.currentSet === 3)
            {
                set3Component
            }
            else if(rootWindow.currentSet === 4)
            {
                set4Component
            }
            else if(rootWindow.currentSet === 5)
            {
                set5Component
            }
            else if(rootWindow.currentSet === 6)
            {
                set6Component
            }
        }
        property alias columBarRef: optMenuRoot.parent
    }


    Component
    {
        id: set1Component

        GridLayout
        {
            columns: 1
            rows: 3

            rowSpacing: 5

            anchors.fill: menuLoader.columnBarRef
            anchors.margins: 10

            Rectangle
            {
                id: drivingProfile

                height: 130
                width: 290
                Layout.topMargin: 25
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: (counter === 0) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr("Load Profile")
                    color: (counter === 0) ? "white" : "black"
                    font.pixelSize: 30
                    font.bold: true
                    y: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Current Profile: " + (rootWindow.driver + 1)
                    color: (counter === 0) ? "white" : "grey"
                    font.pixelSize: 20

                    y: 75
                    anchors.horizontalCenter: parent.horizontalCenter
                }

            }

            Rectangle
            {
                id: engineInfo

                height: 130
                width: 290
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: (counter === 1) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr("Advanced View")
                    color:(counter === 1) ? "white" : "black"
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    font.bold: true
                }
            }

            Rectangle
            {
                id: launchControl

                height: 130
                width: 290
                Layout.bottomMargin: 25
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: (counter === 2) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr("Launch Control")
                    color: (counter === 2) ? "white" : "black"
                    font.pixelSize: 30
                    font.bold: true

                    y: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: (rootWindow.lc_Status === 1) ? "ON" : "OFF"
                    font.pixelSize: 20
                    font.italic: true
                    font.bold: true
                    color: {
                        if(counter === 2) {
                            "white"
                        } else if (counter !== 2) {
                            if (rootWindow.lc_Status === 1) {
                                "#00a8ff"
                            } else {
                                "grey"
                            }
                        }
                    }

                    y: 75
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }

    }

    Component
    {
        id: set2Component

        GridLayout
        {
            columns: 1
            rows: 3

            rowSpacing: 5



            anchors.fill: menuLoader.columnBarRef
            anchors.margins: 10


            Rectangle
            {
                id: brakeBias

                height: 130
                width: 290
                Layout.topMargin: 25
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: (counter === 3) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr("Brake Bias")
                    color: (counter === 3) ? "white" : "black"
                    font.pixelSize: 30
                    font.bold: true

                    y: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "F: " + (brakeBiasObject.biasVal) + " | " + "R: " + (brakeBiasObject.rearBrakeBias)
                    color: (counter === 3) ? "white" : "grey"
                    font.pixelSize: 20

                    y: 75
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Rectangle
            {
                id: tractionControl

                height: 130
                width: 290
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: (counter === 4) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr("Traction Control")
                    color: (counter === 4) ? "white" : "black"
                    font.pixelSize: 30
                    font.bold: true

                    y: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Current Value: " + tract.tractionSwitch
                    color: (counter === 4) ? "white" : "grey"
                    font.pixelSize: 20

                    y: 75
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Rectangle
            {
                id: launchSwitchAimRotary

                height: 130
                width: 290
                Layout.bottomMargin: 25
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: (counter === 5) ? "#00a8ff" : "white"

                Text
                {
                    id: lineOne
                    text: qsTr("Launch Aim")
                    y: 40

                    color: (counter === 5) ? "white" : "black"
                    anchors.horizontalCenter: parent.horizontalCenter

                    font.pixelSize: 30
                    font.bold: true
                }

                Text {
                    text: "Current Value: " + launchAimObj.launchAim
                    color: (counter === 5) ? "white" : "grey"
                    font.pixelSize: 20

                    y: 75
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }

    Component
    {
        id: set4Component

        GridLayout
        {
            columns: 1
            rows: 3

            rowSpacing: 5

            anchors.fill: menuLoader.columnBarRef
            anchors.margins: 10

            Rectangle
            {
                id: antiLag

                height: 130
                width: 290
                Layout.topMargin: 25
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20



                color: (counter === 6) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr("Anti Lag")
                    color: (counter === 6) ? "white" : "black"
                    font.pixelSize: 30
                    font.bold: true

                    y: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Current Value: " + antiLagObj.antiLag
                    color: (counter === 6) ? "white" : "grey"
                    font.pixelSize: 20

                    y: 75
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Rectangle
            {
                id: ignitionTiming

                height: 130
                width: 290
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: (counter === 7) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr("Ignition Timing")
                    color:(counter === 7) ? "white" : "black"
                    font.pixelSize: 30
                    font.bold: true

                    y: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: (rootWindow.ignitionTiming === true) ? "ON" : "OFF"
                    font.pixelSize: 20
                    font.italic: true
                    font.bold: true
                    color: {
                        if(counter === 7) {
                            "white"
                        } else if (counter !== 7) {
                            if (rootWindow.ignitionTiming === true) {
                                "#00a8ff"
                            } else {
                                "grey"
                            }
                        }
                    }

                    y: 75
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Rectangle
            {
                id: mixAim

                height: 130
                width: 290
                Layout.bottomMargin: 25
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: (counter === 8) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr("Fuel Mix Aim")
                    color: (counter === 8) ? "white" : "black"
                    font.pixelSize: 30
                    font.bold: true

                    y: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: (rootWindow.fuelAim === true) ? "ON" : "OFF"
                    font.pixelSize: 20
                    font.italic: true
                    font.bold: true
                    color: {
                        if(counter === 8) {
                            "white"
                        } else if (counter !== 11) {
                            if (rootWindow.fuelAim === true) {
                                "#00a8ff"
                            } else {
                                "grey"
                            }
                        }
                    }

                    y: 75
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }

    Component
    {
        id: set5Component

        GridLayout
        {
            columns: 1
            rows: 3

            rowSpacing: 5

            anchors.fill: menuLoader.columnBarRef
            anchors.margins: 10

            Rectangle
            {
                id: throttlePedalTranslation

                height: 130
                width: 290
                Layout.topMargin: 25
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20



                color: (counter === 9) ? "#00a8ff" : "white"

                Text
                {
                    id: lineOne
                    text: qsTr("Throttle Pedal")

                    color: (counter === 9) ? "white" : "black"

                    y: 20
                    anchors.horizontalCenter: throttlePedalTranslation.horizontalCenter


                    font.pixelSize: 30
                    font.bold: true
                }

                Text
                {
                    text: qsTr("Translation")

                    color: (counter === 9) ? "white" : "black"
                    anchors
                    {
                        top: lineOne.bottom
                        horizontalCenter: throttlePedalTranslation.horizontalCenter
                    }

                    font.pixelSize: 30
                    font.bold: true
                }

                Text {
                    text: (rootWindow.throttleMap === true) ? "ON" : "OFF"
                    font.pixelSize: 20
                    font.italic: true
                    font.bold: true
                    color: {
                        if(counter === 9) {
                            "white"
                        } else if (counter !== 9) {
                            if (rootWindow.throttleMap === true) {
                                "#00a8ff"
                            } else {
                                "grey"
                            }
                        }
                    }

                    y: 90
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Rectangle
            {
                id: unusedSlot1

                height: 130
                width: 290
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: "transparent"

                /*(Text
                {
                    text: qsTr("Ignition Timing")
                    color:(counter === 10) ? "white" : "black"
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    font.bold: true
                }*/
            }

            Rectangle
            {
                id: unusedSlot2

                height: 130
                width: 290
                Layout.bottomMargin: 25
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: "transparent"

                /*Text
                {
                    text: qsTr("Mix Aim")
                    color: (counter === 11) ? "white" : "black"
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    font.bold: true
                }*/
            }
        }
    }

    Component
    {
        id: set3Component

        GridLayout
        {
            columns: 1
            rows: 3

            rowSpacing: 5

            anchors.fill: menuLoader.columnBarRef
            anchors.margins: 10

            Rectangle
            {
                id: profile1

                height: 130
                width: 290
                Layout.topMargin: 25
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20



                color: (counter === 100) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr(" Profile 1")
                    color: (counter === 100) ? "white" : "black"
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    font.bold: true
                }

            }

            Rectangle
            {
                id: profile2

                height: 130
                width: 290
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: (counter === 101) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr(" Profile 2")
                    color:(counter === 101) ? "white" : "black"
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    font.bold: true
                }
            }

            Rectangle
            {
                id: profile3

                height: 130
                width: 290
                Layout.bottomMargin: 25
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: (counter === 102) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr(" Profile 3")
                    color: (counter === 102) ? "white" : "black"
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    font.bold: true
                }
            }
        }
    }

    Component
    {
        id: set6Component

        GridLayout
        {
            columns: 1
            rows: 3

            rowSpacing: 5

            anchors.fill: menuLoader.columnBarRef
            anchors.margins: 10

            Rectangle
            {
                id: profile4

                height: 130
                width: 290
                Layout.topMargin: 25
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20



                color: (counter === 103) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr(" Profile 4")
                    color: (counter === 103) ? "white" : "black"
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    font.bold: true
                }

            }

            Rectangle
            {
                id: profile5

                height: 130
                width: 290
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: (counter === 104) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr(" Profile 5")
                    color:(counter === 104) ? "white" : "black"
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    font.bold: true
                }
            }

            Rectangle
            {
                id: profile6

                height: 130
                width: 290
                Layout.bottomMargin: 25
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: (counter === 105) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr(" Profile 6")
                    color: (counter === 105) ? "white" : "black"
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    font.bold: true
                }
            }
        }
    }


    function updateIgnitionState(profile) {
        JSON.updateIgnition(profile, !rootWindow.ignitionTiming)
        canManager.updatePayload(5, JSON.ignitionTiming)

        rootWindow.ignitionTiming = JSON.ignitionTiming
    }

    function updateFuelAimState(profile) {
        JSON.updateFuelAim(profile, !rootWindow.fuelAim)
        canManager.updatePayload(6, JSON.fuelAim)

        rootWindow.fuelAim = JSON.fuelAim
    }

    function updateThrottleState(profile) {
        JSON.updateThrottleMap(profile, !rootWindow.throttleMap)
        canManager.updatePayload(7, JSON.throttleMap)

        rootWindow.throttleMap = JSON.throttleMap
    }
}



