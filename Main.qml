import Dyno_Info

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

Window
{
    id: rootWindow

    property var info: JSON
    property var canManager: canBus

    property bool loadingComplete: false
    property int speed: 0
    property int currentSet: 1
    property int counter: 0
    property int driver: JSON.driver
    property int lc_Status: 0
    property bool ecuFault: false
    property bool gameMenuVisible: false
    property int gameMenuCounter: 0

    property bool menuShown: false

    width: 800
    height: 480
    visible: true
    title: qsTr("2025 Vehicle Display")
    color: "black"

    flags: Qt.FramelessWindowHint

    Material.theme: Material.Light

    //temporary, will delete later
    ShutdownHandler {
        id: shutdownHandler
    }

    AnimationManager {
        id: animator
    }

    Connections {
        target: canManager

        function onVehicleSpeedChanged() { vehicleInfo.vehicleSpeed = canManager.vehicleSpeed }
        function onRearBrakePresChanged() { vehicleInfo.rearBrakePres = canManager.rearBrakePres }
        function onFrontBrakePresChanged() { vehicleInfo.frontBrakePres = canManager.frontBrakePres }
        function onCoolantTempChanged() { vehicleInfo.coolantTemp = canManager.coolantTemp }
        function onOilTempChanged() { vehicleInfo.oilTemp = canManager.oilTemp }
        function onFuelTempChanged() { vehicleInfo.fuelTemp = canManager.fuelTemp }
        function onExhaustTempChanged() { extraInfoDisplayWidgets.exhaustTemp = canManager.exhaustTemp }
        function onInletAirTempChanged() { extraInfoDisplayWidgets.inletAirTemp = canManager.inletAirTemp }
        function onInletManifoldPresChanged() { extraInfoDisplayWidgets.inletManifoldPres = canManager.inletManifoldPres }
        function onFuelPresChanged() { extraInfoDisplayWidgets.fuelPres = canManager.fuelPres }
        function onFuelMixAimChanged() { extraInfoDisplayWidgets.fuelMixAim = canManager.fuelMixAim }
        function onExhaustLambdaChanged() { extraInfoDisplayWidgets.exhaustLambda = canManager.exhaustLambda }
        function onEcuFaultChanged() { showECUfault() }
    }

    InputManager {
        id: inputManager
    }

    Image
    {
        id: loadingImage
        anchors.centerIn: parent
        source: "assets/images/teamlogo.png"
        visible: !rootWindow.loadingComplete


        Rectangle {
            id: dotContainer
            width: 120
            height: 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: loadingImage.bottom
            anchors.topMargin: 10
            color: "transparent"


            Rectangle
            {
                id: dot_1
                width: 20
                height: 20
                color: "#FFCB05"
                radius: 100
                anchors.left: parent.left
                SequentialAnimation
                {
                    running: true
                    loops: Animation.Infinite
                    ScaleAnimator
                    {
                        target: dot_1
                        from: 1
                        to: 0
                        duration: 1840
                    }
                    ScaleAnimator
                    {
                        target: dot_1
                        from: 0
                        to: 1
                        duration: 1840
                    }
                }
            }


            Rectangle
            {
                id: dot_2
                width: 20
                height: 20
                color: "#FFCB05"
                radius: 100
                anchors.left: dot_1.right
                anchors.leftMargin: 10
                SequentialAnimation
                {
                    running: true
                    PauseAnimation { duration: 120 }
                    SequentialAnimation {
                        loops: Animation.Infinite
                        ScaleAnimator
                        {
                            target: dot_2
                            from: 1
                            to: 0
                            duration: 1840
                        }
                        ScaleAnimator
                        {
                            target: dot_2
                            from: 0
                            to: 1
                            duration: 1840
                        }
                    }
                }
            }


            Rectangle
            {
                id: dot_3
                width: 20
                height: 20
                color: "#FFCB05"
                radius: 100
                anchors.left: dot_2.right
                anchors.leftMargin: 10
                SequentialAnimation
                {
                    running: true
                    PauseAnimation { duration: 240 }
                    SequentialAnimation
                    {
                        loops: Animation.Infinite
                        ScaleAnimator
                        {
                            target: dot_3
                            from: 1
                            to: 0
                            duration: 1840
                        }
                        ScaleAnimator
                        {
                            target: dot_3
                            from: 0
                            to: 1
                            duration: 1840
                        }
                    }
                }
            }


            Rectangle
            {
                id: dot_4
                width: 20
                height: 20
                color: "#FFCB05"
                radius: 100
                anchors.left: dot_3.right
                anchors.leftMargin: 10
                SequentialAnimation
                {
                    running: true
                    PauseAnimation { duration: 360 }
                    SequentialAnimation
                    {
                        loops: Animation.Infinite
                        ScaleAnimator
                        {
                            target: dot_4
                            from: 1
                            to: 0
                            duration: 1840
                        }
                        ScaleAnimator
                        {
                            target: dot_4
                            from: 0
                            to: 1
                            duration: 1840
                        }
                    }
                }
            }
        }
    }

    Timer
    {
        id: loadingTimer
        interval: 2000
        running: true
        repeat: false
        onTriggered: loadingDone()
    }


    Rectangle
    {
        id: uselessRectangle
        anchors
        {
            top: parent.top
            right: parent.right
        }
        width: 1040
        height: 0
        color: "transparent"
        visible: rootWindow.loadingComplete
    }

    Image
    {
        id: teamLogo
        anchors
        {
            top: parent.top
            right: parent.right
        }
        width: 70
        height: 70
        source: "assets/images/teamlogo2.png"
        visible: rootWindow.loadingComplete
    }

    Rectangle
    {
        id: visualRoot
        width: 800
        height: 480
        color: "transparent"

        Rectangle
        {
            id: speedometer
            anchors.centerIn: visualRoot
            width: 200
            height: 200

            color: "transparent"

            Rectangle
            {
                id: speedoNumber
                width: 150
                height: 150
                color: "transparent"
                anchors.centerIn: speedometer

                Text
                {
                    text: vehicleInfo.vehicleSpeed
                    color: "white"
                    anchors.centerIn: speedoNumber
                    font.pixelSize: 110
                    font.bold: true
                    visible: rootWindow.loadingComplete
                }
            }

            Rectangle
            {
                id: speedoUnit
                width: 100
                height: 5
                color: "transparent"

                anchors
                {
                    top: speedoNumber.bottom
                    horizontalCenter: speedoNumber.horizontalCenter
                    topMargin: 10
                }

                Text
                {
                    anchors.centerIn: parent
                    text: qsTr("MPH")
                    font.pixelSize: 60
                    font.bold: true
                    color: "#1e272e"
                    visible: rootWindow.loadingComplete
                }
            }
        }
    }

    Rectangle
    {
        id: iconBar
        width: 800
        height: 60
        color: "transparent"

        y: 15

        Image
        {
            id: launchControlImage
            source: "assets/images/LC.png"

            anchors
            {
                right: parent.right
                rightMargin: 80
            }

            visible: false
        }

        visible: true
    }

    Rectangle
    {
        id: warningIcons
        width: 70
        height: 400
        color: "transparent"

        anchors
        {
            right: parent.right
            top: teamLogo.bottom
        }

        Image
        {
            id: ecuFaultImage
            source: "assets/images/WARN.png"

            anchors
            {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }
            visible: false
        }

        visible: true
    }

    Text
    {
        id: speedoUnitInfoScreen

        x: 130 //110?
        y: -20
        text: qsTr("MPH")
        font.pixelSize: 40
        font.bold: true
        color: "#1e272e"
        visible: false
    }

    Rectangle
    {
        id: columnBar

        anchors
        {
            top: uselessRectangle.bottom
            bottom: parent.bottom
            margins: 15
        }

        width: 300
        height: 50
        radius: 20
        color: "#1E1E1E"
        x: -columnBar.width
        visible: true

        OptionsMenu {
            id: optMenu
            anchors.fill: parent
        }
    }

    Rectangle
    {
        id: gameMenuRect

        anchors {
            top: uselessRectangle.bottom
            bottom: parent.bottom
            margins: 15

        }
        x: rootWindow.width
        width: 300
        height: 50
        visible: gameMenuVisible
        color: "#1E1E1E"
        radius: 20

        GameMenu {
            id: gameMenu
            anchors.fill: parent
        }
    }

    Rectangle
    {
        id: brakeBiasScreen
        radius: 25
        visible: false
        anchors
        {
            top: columnBar.top
            bottom: columnBar.bottom
            left: columnBar.left
            right: columnBar.right
        }

        BrakeBias
        {
            id: brakeBiasObject
            anchors.fill: parent
        }
    }

    Rectangle
    {
        id: tractionControlScreen
        radius: 25
        visible: false
        anchors
        {
            top: columnBar.top
            bottom: columnBar.bottom
            left: columnBar.left
            right: columnBar.right
        }

        TractionControl
        {
            id: tract
            anchors.fill: parent
        }
    }

    Rectangle
    {
        id: engineInfoScreen

        x: -800
        y: 140

        width: 800
        height: 310
        color: "transparent"
        visible: false

        VehicleInfoDisplay
        {
            id: vehicleInfo
            anchors.fill: parent
        }
    }

    Rectangle
    {
        id: statusUpdate

        width: 230
        height: 45
        radius: 10
        y: 500

        anchors
        {
            horizontalCenter: visualRoot.horizontalCenter
        }

        color: "#1E1E1E"

        Text
        {
            id: statusMessage
            text: qsTr("Default")
            color: "white"
            font.bold: true
            font.pixelSize: 20

            anchors
            {
                left: statusImage.right
                right: statusUpdate.right
                verticalCenter: statusUpdate.verticalCenter
                margins: 15

            }
        }

        Image
        {
            id: statusImage
            source: "assets/images/INFO.png"
            height: 40
            width: 40

            anchors
            {
                verticalCenter: statusUpdate.verticalCenter
                left: statusUpdate.left
                margins: 5
            }
        }
    }

    Rectangle
    {
        id: statusUpdateAdvancedView

        width: 230
        height: 45
        radius: 10
        x: 290
        y: -500

        color: "#1E1E1E"

        Text
        {
            id: statusMessageAdvancedView
            text: qsTr("Default")
            color: "white"
            font.bold: true
            font.pixelSize: 20

            anchors
            {
                left: statusImageAdvancedView.right
                right: statusUpdateAdvancedView.right
                verticalCenter: statusUpdateAdvancedView.verticalCenter
                margins: 15

            }
        }

        Image
        {
            id: statusImageAdvancedView
            source: "assets/images/INFO.png"
            height: 40
            width: 40

            anchors
            {
                verticalCenter: statusUpdateAdvancedView.verticalCenter
                left: statusUpdateAdvancedView.left
                margins: 5
            }
        }
    }

    Rectangle
    {
        id: extraInfoWidgets
        width: 800
        height: 360
        y: 110
        color: "black"
        visible: false

        VehicleInfoDisplayExtraWidgets
        {
            id: extraInfoDisplayWidgets
            anchors.fill: parent
        }
    }

    Item
    {
        focus: true
        Keys.onPressed: (event) =>
        {
            if (event.key === Qt.Key_Right) {
                inputManager.rightPress()
            }
            else if(event.key === Qt.Key_Left) {
                inputManager.leftPress()
            }
            else if(event.key === Qt.Key_Down) {
                inputManager.downPress()
            }
            else if(event.key === Qt.Key_Up) {
                inputManager.upPress()
            }
            else if(event.key === Qt.Key_Escape) {
                close()
            }
            else if(event.key === Qt.Key_Q) {
                close()
            }
            else if (event.key === Qt.Key_W) {
                if(engineInfoScreen.visible === true)
                {
                    ecuFaultImage.visible = true
                    statusImageAdvancedView.source = "assets/images/WARN.png"
                    statusMessageAdvancedView.text = "ECU fault"
                    statusMessageAdvancedView.text.pixelSize = 20
                    animator.advancedViewStatusUpdateAnimation_START()
                }
                else
                {
                    ecuFaultImage.visible = true
                    statusImage.source = "assets/images/WARN.png"
                    statusMessage.text = "ECU fault"
                    statusMessage.text.pixelSize = 20
                    animator.statusUpdateAnimation_START()
                }
            }
            else if (event.key === Qt.Key_P) {
                shutdownHandler.powerOFF()
            }
            else if (event.key === Qt.Key_M) {
                console.log(gameMenuCounter)
            }
        }
    }

    function loadingDone() {
        rootWindow.loadingComplete = true

        statusMessage.text = "Profile Loaded:  " + (driver + 1)
        statusImage.source = "assets/images/INFO.png"
        statusMessage.font.pixelSize = 14
        animator.statusUpdateAnimation_START()
    }

    function loadNewProfile(profileNum) {
        JSON.loadProfile(profileNum)

        driver = JSON.driver
        brakeBiasObject.biasVal = JSON.biasVal
        brakeBiasObject.rearBrakeBias = (100 - JSON.biasVal)
        tract.tractionSwitch = JSON.tractionSwitch

        canManager.updatePayload(0, brakeBiasObject.biasVal)
        canManager.updatePayload(1, (tract.tractionSwitch * 3))
        // add other properties when done
    }

    function updateBias(profile, bias) {
        JSON.updateBrakeBias(profile, bias)
        canManager.updatePayload(0, JSON.biasVal)

        brakeBiasObject.biasVal = JSON.biasVal
        brakeBiasObject.rearBrakeBias = (100 - JSON.biasVal)
    }

    function updateTraction(profile, traction) {
        JSON.updateTractionCtl(profile, traction)
        canManager.updatePayload(1, (JSON.tractionSwitch *3)) // *3 bc motec rotary bullshit

        tract.tractionSwitch = JSON.tractionSwitch
    }

    function showECUfault() {
        rootWindow.ecuFault = canManager.ecuFault
        if(rootWindow.ecuFault === true) {
            if(engineInfoScreen.visible === true) {
                ecuFaultImage.visible = true
                statusImageAdvancedView.source = "assets/images/WARN.png"
                statusMessageAdvancedView.text = "ECU fault"
                statusMessageAdvancedView.text.pixelSize = 20
                animator.advancedViewStatusUpdateAnimation_START()
            }
            else {
                ecuFaultImage.visible = true
                statusImage.source = "assets/images/WARN.png"
                statusMessage.text = "ECU fault"
                statusMessage.text.pixelSize = 20
                animator.statusUpdateAnimation_START()
            }
        }
        else {
            ecuFaultImage.visible = fasle
        }
    }
}
