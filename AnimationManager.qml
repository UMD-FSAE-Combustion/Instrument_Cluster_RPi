import QtQuick

Item {

    PropertyAnimation
    {
       id: animationRightSpeedometer
       target: visualRoot
       property: "x"
       to: 165
       duration: 300
    }

    PropertyAnimation
    {
       id: animationCenterSpeedometer
       target: visualRoot
       property: "x"
       to: speedoNumber.horizontalCenter
       duration: 350
    }
    PropertyAnimation
    {
       id: animationLeftSpeedometer
       target: visualRoot
       property: "x"
       to: -165
       duration: 300
    }

    PropertyAnimation
   {
      id: animationUpSpeedometer
      target: visualRoot
      property: "y"
      to: -180
      duration: 200
   }

    PropertyAnimation
    {
       id: animationDownSpeedometer
       target: visualRoot
       property: "y"
       to: speedoNumber.verticalCenter
       duration: 300
    }

    PropertyAnimation
    {
       id: animationTopLeftSpeedometer
       target: visualRoot
       property: "x"
       to: -320
       duration: 200
    }

    PropertyAnimation
    {
       id: animationDownInfoScreenSpeedometer
       target: speedoUnitInfoScreen
       property: "y"
       to: 60
       duration: 300
    }

    PropertyAnimation
    {
       id: animationUpInfoScreenSpeedometer
       target: speedoUnitInfoScreen
       property: "y"
       to: -20
       duration: 300
    }

    PropertyAnimation {
        id: gameMenuAnimationRight
        target: gameMenuRect
        property: "x"
        to: rootWindow.width
        duration: 300
        onFinished: {
            gameMenuVisible = false
        }
    }

    PropertyAnimation {
        id: gameMenuAnimationLeft
        target: gameMenuRect
        property: "x"
        to: rootWindow.width - gameMenuRect.width - 15
        duration: 300
    }

    PropertyAnimation
    {
       id: animationRight
       target: columnBar
       property: "x"
       to: rootWindow.width - 785
       duration: 300
    }

    PropertyAnimation
    {
       id: animationLeft
       target: columnBar
       property: "x"
       to: columnBar.width - rootWindow.width
       duration: 300
    }

    PropertyAnimation
    {
        id: engineInfoAnimationRight
        target: engineInfoScreen
        property: "x"
        to: 800
        duration: 300
    }

    PropertyAnimation
    {
        id: engineInfoAnimationLeft
        target: engineInfoScreen
        property: "x"
        to: -800
        duration: 300
    }


    // SEQUENTIAL ANIMATIONS //

    SequentialAnimation
    {
        id: statusUpdateAnimation
        running: false

        PauseAnimation
        {
            duration: 600
        }

        ParallelAnimation
        {
            NumberAnimation
            {
                target: visualRoot
                property: "y"
                to: -50
                duration: 300
                easing.type: Easing.InOutQuad
            }


            NumberAnimation
            {
                id: statusUpdateAnimationUp
                target: statusUpdate
                property: "y"
                to: 330
                duration: 300
                easing.type: Easing.InOutQuad
            }
        }


        PauseAnimation
        {
            duration: 1750
        }

        ParallelAnimation
        {
            NumberAnimation
            {
                id: statusUpdateAnimationDown
                target: statusUpdate
                property: "y"
                to: 500
                duration: 300
                easing.type: Easing.InOutQuad
            }

            NumberAnimation
            {
                target: visualRoot
                property: "y"
                to: 0
                duration: 300
                easing.type: Easing.InOutQuad
            }
        }
    }

    SequentialAnimation
    {
        id: advancedViewStatusUpdateAnimation
        running: false

        PauseAnimation
        {
            duration: 600
        }

        ParallelAnimation
        {
            NumberAnimation
            {
                id: advancedViewStatusUpdateAnimationUp
                target: statusUpdateAdvancedView
                property: "y"
                to: 55
                duration: 300
                easing.type: Easing.InOutQuad
            }
        }

        PauseAnimation
        {
            duration: 1750
        }

        ParallelAnimation
        {
            NumberAnimation
            {
                id: advancedViewStatusUpdateAnimationDown
                target: statusUpdateAdvancedView
                property: "y"
                to: -500
                duration: 300
                easing.type: Easing.InOutQuad
            }
        }
    }


    // function calls //

    function animationRightSpeedometer_START() {
        animationRightSpeedometer.start()
    }

    function animationCenterSpeedometer_START() {
        animationCenterSpeedometer.start()
    }

    function animationLeftSpeedometer_START() {
        animationLeftSpeedometer.start()
    }

    function animationUpSpeedometer_START() {
        animationUpSpeedometer.start()
    }

    function animationDownSpeedometer_START() {
        animationDownSpeedometer.start()
    }

    function animationTopLeftSpeedometer_START() {
        animationTopLeftSpeedometer.start()
    }

    function animationDownInfoScreenSpeedometer_START() {
        animationDownInfoScreenSpeedometer.start()
    }

    function animationUpInfoScreenSpeedometer_START() {
        animationUpInfoScreenSpeedometer.start()
    }

    function gameMenuAnimationRight_START() {
        gameMenuAnimationRight.start()
    }

    function gameMenuAnimationLeft_START() {
        gameMenuAnimationLeft.start()
    }

    function animationRight_START() {
        animationRight.start()
    }

    function animationLeft_START() {
        animationLeft.start()
    }

    function engineInfoAnimationRight_START() {
        engineInfoAnimationRight.start()
    }

    function engineInfoAnimationLeft_START() {
        engineInfoAnimationLeft.start()
    }

    function statusUpdateAnimation_START() {
        statusUpdateAnimation.start()
    }

    function statusUpdateAnimation_RUNNING() {
        return statusUpdateAnimation.running
    }

    function statusUpdateAnimation_STOP() {
        statusUpdateAnimation.stop()
    }

    function advancedViewStatusUpdateAnimation_START() {
        advancedViewStatusUpdateAnimation.start()
    }
}
