import Dyno_Info

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

Window {
    id: rootWindow

    property var loadingSplash: splashScreen
    property var info: JSON
    property var canManager: canBus
    property var gpioInput: gpio

    property int currentSet: 1
    property int counter: 0

    property int driver: JSON.driver
    property int lc_Status: 0
    property bool ecuFault: false
    property string faultMessage: ""

    property bool ignitionTiming: JSON.ignitionTiming
    property bool throttleMap: JSON.throttleMap
    property bool fuelAim: JSON.fuelAim

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

        function onInitialized() {
            splashScreen.visible = false
            loadingTimer.start()
        }

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

    Connections {
        target: gpioInput

        function onButtonRight() { inputManager.rightPress() }
        function onButtonLeft() { inputManager.leftPress() }
        function onButtonTop() { inputManager.upPress() }
        function onButtonBottom() { inputManager.downPress() }

        function onLc_Pressed() { optMenu.lc_Engaged() }
        function onLc_Released() { optMenu.lc_Disengaged() }
    }

    InputManager {
        id: inputManager
    }

    SplashScreen {
        id: splashScreen
        visible: true
    }

    LoadingScreen {
        id: loadApp
    }

    Timer {
        id: loadingTimer
        interval: 2000

        running: true
        repeat: false
        onTriggered: loadingDone()
    }

    Rectangle {
        id: uselessRectangle
        anchors {
            top: parent.top
            right: parent.right
        }
        width: 1040
        height: 0
        color: "transparent"
        visible: loadApp.loadingComplete
    }

    Image {
        id: teamLogo
        anchors {
            top: parent.top
            right: parent.right
        }
        width: 70
        height: 70
        source: "assets/images/teamlogo2.png"
        visible: loadApp.loadingComplete
    }

    Rectangle {
        id: visualRoot
        width: 800
        height: 480
        color: "transparent"

        Rectangle {
            id: speedometer
            anchors.centerIn: visualRoot
            width: 200
            height: 200

            color: "transparent"

            Rectangle {
                id: speedoNumber
                width: 150
                height: 150
                color: "transparent"
                anchors.centerIn: speedometer

                Text {
                    text: vehicleInfo.vehicleSpeed
                    color: "white"
                    anchors.centerIn: speedoNumber
                    font.pixelSize: 110
                    font.bold: true
                    visible: loadApp.loadingComplete
                }
            }

            Rectangle {
                id: speedoUnit
                width: 100
                height: 5
                color: "transparent"

                anchors {
                    top: speedoNumber.bottom
                    horizontalCenter: speedoNumber.horizontalCenter
                    topMargin: 10
                }

                Text {
                    anchors.centerIn: parent
                    text: qsTr("MPH")
                    font.pixelSize: 60
                    font.bold: true
                    color: "#1e272e"
                    visible: loadApp.loadingComplete
                }
            }
        }
    }

    Rectangle {
        id: iconBar
        width: 800
        height: 60
        color: "transparent"

        y: 15

        Image {
            id: ecuFaultImage
            source: "assets/images/WARN.png"

            anchors {
                right: parent.right
                rightMargin: 80
            }
            visible: false
        }

        Image {
            id: launchControlImage
            source: "assets/images/LC.png"

            anchors {
                right: ecuFaultImage.left
                //rightMargin: 80
            }

            visible: false
        }

        visible: true
    }

    Rectangle {
        id: lockIcon
        width: 70
        height: 400
        color: "transparent"

        y: 60
        anchors.right: parent.right

        Image {
            id: speedLock
            source: "assets/images/lock_icon.png"
            height: 40
            width: 30

            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }
            visible: (vehicleInfo.vehicleSpeed > 0) ? true : false
        }
        visible: true
    }

    Text {
        id: speedoUnitInfoScreen

        x: 140 //130 //110?
        y: -20
        text: qsTr("MPH")
        font.pixelSize: 40
        font.bold: true
        color: "#1e272e"
        visible: false
    }

    Rectangle {
        id: columnBar

        anchors {
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

    Rectangle {
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

    Rectangle {
        id: brakeBiasScreen
        radius: 25
        visible: false
        anchors {
            top: columnBar.top
            bottom: columnBar.bottom
            left: columnBar.left
            right: columnBar.right
        }

        BrakeBias {
            id: brakeBiasObject
            anchors.fill: parent
        }
    }

    Rectangle {
        id: pongGameRect
        anchors {
            top: uselessRectangle.bottom
            bottom: parent.bottom
            margins: 15
        }
        x: rootWindow.width
        width: 300
        height: 50
        visible: false
        color: "#1E1E1E"
        radius: 20

        Pong {
            id: pongGame
            anchors.fill: parent
            visible: false
        }
    }

    Rectangle {
        id: flappyBirdRect
        anchors {
            top: uselessRectangle.bottom
            bottom: parent.bottom
            margins: 15
        }
        x: rootWindow.width
        width: 300
        height: 50
        visible: false
        color: "#1E1E1E"
        radius: 20

        FlappyBird {
            id: flappyBirdGame
            anchors.fill: parent
            visible: false

            onGameExited: {
                // Hide flappy bird game
                flappyBirdRect.visible = false
                flappyBirdGame.visible = false

                // Show game menu again
                gameMenuVisible = true
                gameMenuRect.visible = true
            }
        }
    }


    /*Loader
    {
        id: pacManLoader
        anchors.fill: parent
        source: "PacMan.qml"
        active: false
        visible: false

        onLoaded: {
            item.gameExited.connect(function()
            {
                pacManLoader.active = false
            })
        }

        PacMan
        {
            id:pacManGame
        }
    }*/
    Rectangle {
        id: pacManWindow
        anchors.fill: parent
        visible: false

        PacMan {
            id: pacManGame
        }
    }

    Rectangle {
        id: pacManStartScreen
        visible: false

        Image {
            id: mainMenu
            source: "assets/images/pacManMenuScreen.png"
        }
    }

    Rectangle {
        id: tractionControlScreen
        radius: 25
        visible: false
        anchors {
            top: columnBar.top
            bottom: columnBar.bottom
            left: columnBar.left
            right: columnBar.right
        }

        TractionControl {
            id: tract
            anchors.fill: parent
        }
    }

    Rectangle {
        id: antiLagScreen
        radius: 25
        visible: false
        anchors {
            top: columnBar.top
            bottom: columnBar.bottom
            left: columnBar.left
            right: columnBar.right
        }

        AntilagControl {
            id: antiLagObj
            anchors.fill: parent
        }
    }

    Rectangle {
        id: launchAimScreen
        radius: 25
        visible: false
        anchors {
            top: columnBar.top
            bottom: columnBar.bottom
            left: columnBar.left
            right: columnBar.right
        }

        LaunchAimControl {
            id: launchAimObj
            anchors.fill: parent
        }
    }

    Rectangle {
        id: engineInfoScreen

        x: -800
        y: 140

        width: 800
        height: 310
        color: "transparent"
        visible: false

        VehicleInfoDisplay {
            id: vehicleInfo
            anchors.fill: parent
        }
    }

    Rectangle {
        id: statusUpdate

        width: 280 //230
        height: 45
        radius: 10
        y: 500

        anchors.horizontalCenter: visualRoot.horizontalCenter

        color: "#1E1E1E"

        Text {
            id: statusMessage
            text: qsTr("Default")
            color: "white"
            font.bold: true
            font.pixelSize: 20

            anchors {
                left: statusImage.right
                right: statusUpdate.right
                verticalCenter: statusUpdate.verticalCenter
                margins: 10
            }
        }

        Image {
            id: statusImage
            source: "assets/images/INFO.png"
            height: 40
            width: 40

            anchors {
                verticalCenter: statusUpdate.verticalCenter
                left: statusUpdate.left
                margins: 5
            }
        }
    }

    Rectangle {
        id: statusUpdateAdvancedView

        width: 280 //230
        height: 45
        radius: 10
        x: 290
        y: -500

        color: "#1E1E1E"

        Text {
            id: statusMessageAdvancedView
            text: qsTr("Default")
            color: "white"
            font.bold: true
            font.pixelSize: 20

            anchors {
                left: statusImageAdvancedView.right
                right: statusUpdateAdvancedView.right
                verticalCenter: statusUpdateAdvancedView.verticalCenter
                margins: 10
            }
        }

        Image {
            id: statusImageAdvancedView
            source: "assets/images/INFO.png"
            height: 40
            width: 40

            anchors {
                verticalCenter: statusUpdateAdvancedView.verticalCenter
                left: statusUpdateAdvancedView.left
                margins: 5
            }
        }
    }

    Rectangle {
        id: extraInfoWidgets
        width: 800
        height: 360
        y: 110
        color: "black"
        visible: false

        VehicleInfoDisplayExtraWidgets {
            id: extraInfoDisplayWidgets
            anchors.fill: parent
        }
    }

    Item {
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
                Qt.quit()
            }
            else if(event.key === Qt.Key_Q) {
                Qt.quit()
            }
            else if (event.key === Qt.Key_W) {
                if(engineInfoScreen.visible === true)
                {
                    if(rootWindow.ecuFault === false) {
                        rootWindow.ecuFault = true
                        ecuFaultImage.visible = true
                        statusImageAdvancedView.source = "assets/images/WARN.png"
                        rootWindow.faultMessage = "ECU fault"
                        statusMessageAdvancedView.text = rootWindow.faultMessage
                        statusMessageAdvancedView.text.pixelSize = 20
                        animator.advancedViewStatusUpdateAnimation_START()
                    }
                    else {
                        rootWindow.ecuFault = false
                        ecuFaultImage.visible = false
                    }
                }
                else
                {
                    if(rootWindow.ecuFault === false)
                    {
                        rootWindow.ecuFault = true
                        ecuFaultImage.visible = true
                        statusImage.source = "assets/images/WARN.png"
                        rootWindow.faultMessage = "ECU fault"
                        statusMessage.text = rootWindow.faultMessage
                        statusMessage.text.pixelSize = 20
                        animator.statusUpdateAnimation_START()
                    }
                    else {
                        rootWindow.ecuFault = false
                        ecuFaultImage.visible = false
                    }
                }
            }
            else if (event.key === Qt.Key_P) {
                shutdownHandler.powerOFF()
            }
            else if (event.key === Qt.Key_S) {
                if(vehicleInfo.vehicleSpeed === 0) {
                    vehicleInfo.vehicleSpeed = 70
                } else {
                    vehicleInfo.vehicleSpeed = 0
                }
            }

            // Handle key press for Flappy Bird if visible
            if (flappyBirdGame.visible) {
                flappyBirdGame.handleKeyPress(event.key === Qt.Key_Up ? "UP" :
                                             event.key === Qt.Key_Space ? "SPACE" :
                                             event.key === Qt.Key_Escape ? "ESCAPE" : "")
            }
        }
    }

    function loadingDone() {
        loadApp.loadingComplete = true

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
        launchAimObj.launchAim = JSON.launchAim
        antiLagObj.antiLag = JSON.antiLag
        ignitionTiming = JSON.ignitionTiming
        fuelAim = JSON.fuelAim
        throttleMap = JSON.throttleMap

        canManager.updatePayload(0, brakeBiasObject.biasVal)
        canManager.updatePayload(1, (tract.tractionSwitch * 3))
        canManager.updatePayload(2, (launchAimObj.launchAim * 3))
        canManager.updatePayload(3, (antiLagObj.antiLag * 3))
        canManager.updatePayload(5, ignitionTiming)
        canManager.updatePayload(6, fuelAim)
        canManager.updatePayload(7, throttleMap)
    }

    function showECUfault() {
        rootWindow.ecuFault = canManager.ecuFault
        if (rootWindow.ecuFault === true) {
            rootWindow.faultMessage = canManager.faultMessage
            if (engineInfoScreen.visible === true) {
                ecuFaultImage.visible = true
                statusImageAdvancedView.source = "assets/images/WARN.png"
                statusMessageAdvancedView.text = faultMessage
                statusMessageAdvancedView.text.pixelSize = 20
                animator.advancedViewStatusUpdateAnimation_START()
            } else {
                ecuFaultImage.visible = true
                statusImage.source = "assets/images/WARN.png"
                statusMessage.text = faultMessage
                statusMessage.text.pixelSize = 20
                animator.statusUpdateAnimation_START()
            }
        } else {
            ecuFaultImage.visible = false
        }
    }
}
