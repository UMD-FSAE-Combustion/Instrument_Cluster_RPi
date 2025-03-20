import QtQuick

Item {

    function rightPress() {
        if(vehicleInfo.vehicleSpeed === 0) {
            if (pongGame.visible) {
                pongGame.visible = false
                pongGameRect.x = rootWindow.width
                gameMenuVisible = true
                gameMenuRect.x = rootWindow.width - gameMenuRect.width - 15
                gameMenuCounter = 0
            }
            else if (gameMenuVisible &&  gameMenuRect.x === rootWindow.width - gameMenuRect.width - 15) {
                animator.animationCenterSpeedometer_START()
                animator.gameMenuAnimationRight_START()
                gameMenuCounter = 0
                menuShown = false
            }
            else if(columnBar.x < 0 && menuShown === false)
            {
                menuShown = true
                animator.animationRightSpeedometer_START()
                animator.animationRight_START()
            }
            else if(brakeBiasScreen.visible === true)
            {
                if(brakeBiasObject.rearBrakeBias !== (100 - JSON.biasVal)) {
                    brakeBiasObject.updateBias(driver, (100 - brakeBiasObject.rearBrakeBias))
                    animator.animationCenterSpeedometer_START()
                    animator.animationLeft_START()

                    statusMessage.text = "Settings Updated"
                    statusImage.source = "assets/images/INFO.png"
                    statusMessage.font.pixelSize = 20
                    animator.statusUpdateAnimation_START()

                    counter = 0
                    currentSet = 1
                    brakeBiasScreen.visible = false
                    menuShown = false
                }
                else {
                    animator.animationCenterSpeedometer_START()
                    animator.animationLeft_START()

                    counter = 0
                    currentSet = 1
                    brakeBiasScreen.visible = false
                    menuShown = false
                }
            }
            else if(tractionControlScreen.visible === true)
            {
                if(tract.tractionSwitch !== JSON.tractionSwitch)
                {
                    tract.updateTraction(driver, tract.tractionSwitch)
                    animator.animationCenterSpeedometer_START()
                    animator.animationLeft_START()

                    statusMessage.text = "Settings Updated"
                    statusImage.source = "assets/images/INFO.png"
                    statusMessage.font.pixelSize = 20
                    animator.statusUpdateAnimation_START()

                    counter = 0
                    currentSet = 1
                    tractionControlScreen.visible = false
                    menuShown = false
                }
                else
                {
                    animator.animationCenterSpeedometer_START()
                    animator.animationLeft_START()

                    counter = 0
                    currentSet = 1
                    tractionControlScreen.visible = false
                    menuShown = false
                }
            }
            else if(launchAimScreen.visible === true)
            {
                if(launchAimObj.launchAim !== JSON.launchAim)
                {
                    launchAimObj.updateLaunchAimSetting(driver, launchAimObj.launchAim)
                    animator.animationCenterSpeedometer_START()
                    animator.animationLeft_START()

                    statusMessage.text = "Setting Updated"
                    statusImage.source = "assets/images/INFO.png"
                    statusMessage.font.pixelSize = 20
                    animator.statusUpdateAnimation_START()

                    counter = 0
                    currentSet = 1
                    launchAimScreen.visible = false
                    menuShown = false
                }
                else
                {
                    animator.animationCenterSpeedometer_START()
                    animator.animationLeft_START()

                    counter = 0
                    currentSet = 1
                    launchAimScreen.visible = false
                    menuShown = false
                }
            }
            else if(antiLagScreen.visible === true)
            {
                if(antiLagObj.antiLag !== JSON.antiLag)
                {
                    antiLagObj.updateAntiLagSetting(driver, antiLagObj.antiLag)
                    animator.animationCenterSpeedometer_START()
                    animator.animationLeft_START()

                    statusMessage.text = "Setting Updated"
                    statusImage.source = "assets/images/INFO.png"
                    statusMessage.font.pixelSize = 20
                    animator.statusUpdateAnimation_START()

                    counter = 0
                    currentSet = 1
                    antiLagScreen.visible = false
                    menuShown = false
                }
                else
                {
                    animator.animationCenterSpeedometer_START()
                    animator.animationLeft_START()

                    counter = 0
                    currentSet = 1
                    antiLagScreen.visible = false
                    menuShown = false
                }
            }
            else if(columnBar.x > 0 && counter === 0)
            {
                currentSet = 3
                counter = 100
            }
            else if(currentSet === 3 || currentSet === 6)
            {
                animator.animationCenterSpeedometer_START()
                animator.animationLeft_START()

                if((counter - 100) !== JSON.driver) {
                    loadNewProfile(counter - 100)

                    statusMessage.text = "Profile Loaded:  " + (driver + 1)
                    statusImage.source = "assets/images/INFO.png"
                    statusMessage.font.pixelSize = 14
                    animator.statusUpdateAnimation_START()
                }
                counter = 0
                currentSet = 1
                menuShown = false
            }
            else if(counter === 3)
            {
                brakeBiasScreen.visible = true
            }
            else if(counter === 4)
            {
                tractionControlScreen.visible = true
            }
            else if(counter === 1 && engineInfoScreen.visible !== true)
            {
                columnBar.visible = false
                animator.engineInfoAnimationRight_START()
                animator.animationUpSpeedometer_START()
                animator.animationTopLeftSpeedometer_START()
                animator.animationDownInfoScreenSpeedometer_START()

                if(animator.statusUpdateAnimation_RUNNING()) {
                    animator.statusUpdateAnimation_STOP()
                    statusUpdate.visible = false
                    statusUpdate.y = 500
                    statusUpdate.visible = true
                }

                engineInfoScreen.visible = true
                speedoUnitInfoScreen.visible = true
                speedoUnit.visible = false
            }
            else if(engineInfoScreen.visible === true)
            {
                extraInfoWidgets.visible = true
            }
            else if(counter === 2)
            {
                if(lc_Status === 0) {
                    lc_Status = 1
                    canManager.updatePayload(4, lc_Status)

                    statusMessage.text = "Launch Control: Active"
                    statusImage.source = "assets/images/LC.png"
                    statusMessage.font.pixelSize = 15
                    animator.statusUpdateAnimation_START()

                    launchControlImage.visible = true
                }
                else {
                    lc_Status = 0
                    canManager.updatePayload(4, lc_Status)

                    statusMessage.text = "Launch Control: Inactive"
                    statusImage.source = "assets/images/LC.png"
                    statusMessage.font.pixelSize = 14
                    animator.statusUpdateAnimation_START()

                    launchControlImage.visible = false
                }
            }
            else if(counter === 5)
            {
                launchAimScreen.visible = true
            }
            else if(counter === 6)
            {
                antiLagScreen.visible = true
            }
            else if(counter === 7)
            {
                optMenu.updateIgnitionState(driver)
            }
            else if(counter === 8)
            {
                optMenu.updateFuelAimState(driver)
            }
            else if(counter === 9)
            {
                optMenu.updateThrottleState(driver)
            }
        }
    }

    function leftPress() {
        if(vehicleInfo.vehicleSpeed === 0) {
            if(columnBar.x < 0){
                if (!gameMenuVisible && menuShown === false)
                {
                    menuShown = true
                    gameMenuVisible = true
                    gameMenu.x = rootWindow.width
                    animator.animationLeftSpeedometer_START()
                    animator.gameMenuAnimationLeft_START()
                }
                else if(gameMenuVisible && gameMenuRect.x === rootWindow.width - gameMenuRect.width - 15)
                {
                    if (gameMenuCounter === 0)
                    {
                        gameMenuVisible = false
                        pongGame.visible = true
                        pongGameRect.visible = true
                        pongGameRect.x = rootWindow.width - pongGameRect.width - 15
                        pongGame.fullReset()
                    }
                    else if (gameMenuCounter === 1)
                    {
                        console.log("Launching Pacman")
                    }
                }
            }
            else if(counter > 99) {
                if((counter - 100 ) !== JSON.driver) {
                    loadNewProfile(counter - 100)

                    statusMessage.text = "Profile Loaded:  " + (driver + 1)
                    statusImage.source = "assets/images/INFO.png"
                    statusMessage.font.pixelSize = 14
                    animator.statusUpdateAnimation_START()
                }
                currentSet = 1
                counter = 0
            }
            else if(counter === 3 && brakeBiasScreen.visible === true)
            {
                if(brakeBiasObject.rearBrakeBias !== (100 - JSON.biasVal)) {
                    brakeBiasObject.updateBias(driver, (100 - brakeBiasObject.rearBrakeBias))
                    brakeBiasScreen.visible = false

                    statusMessage.text = "Setting Updated"
                    statusImage.source = "assets/images/INFO.png"
                    statusMessage.font.pixelSize = 20
                    animator.statusUpdateAnimation_START()

                    counter = 3
                    currentSet = 2
                }
                else {
                    counter = 3
                    currentSet = 2
                    brakeBiasScreen.visible = false
                }
            }
            else if(counter === 4 && tractionControlScreen.visible === true)
            {
                if(tract.tractionSwitch !== JSON.tractionSwitch)
                {
                    tract.updateTraction(driver, tract.tractionSwitch)

                    statusMessage.text = "Setting Updated"
                    statusImage.source = "assets/images/INFO.png"
                    statusMessage.font.pixelSize = 20
                    animator.statusUpdateAnimation_START()

                    counter = 4
                    currentSet = 2
                    tractionControlScreen.visible = false
                }
                else
                {
                    counter = 4
                    currentSet = 2
                    tractionControlScreen.visible = false
                }
            }
            else if(counter === 5 && launchAimScreen.visible === true)
            {
                if(launchAimObj.launchAim !== JSON.launchAim)
                {
                    launchAimObj.updateLaunchAimSetting(driver, launchAimObj.launchAim)

                    statusMessage.text = "Setting Updated"
                    statusImage.source = "assets/images/INFO.png"
                    statusMessage.font.pixelSize = 20
                    animator.statusUpdateAnimation_START()

                    counter = 5
                    currentSet = 2
                    launchAimScreen.visible = false
                }
                else
                {
                    counter = 5
                    currentSet = 2
                    launchAimScreen.visible = false
                }
            }
            else if(counter === 6 && antiLagScreen.visible === true)
            {
                if(antiLagObj.antiLag !== JSON.antiLag)
                {
                    antiLagObj.updateAntiLagSetting(driver, antiLagObj.antiLag)

                    statusMessage.text = "Setting Updated"
                    statusImage.source = "assets/images/INFO.png"
                    statusMessage.font.pixelSize = 20
                    animator.statusUpdateAnimation_START()

                    counter = 6
                    currentSet = 4
                    antiLagScreen.visible = false
                }
                else
                {
                    counter = 6
                    currentSet = 4
                    antiLagScreen.visible = false
                }
            }
            else if(extraInfoWidgets.visible === true)
            {
                extraInfoWidgets.visible = false
            }
            else if (counter === 1 && engineInfoScreen.visible === true)
            {
                columnBar.visible = true
                animator.engineInfoAnimationLeft_START()
                engineInfoScreen.visible = false
                animator.animationRight_START()
                animator.animationRightSpeedometer_START()
                animator.animationDownSpeedometer_START()
                animator.animationUpInfoScreenSpeedometer_START()
                speedoUnit.visible = true
                speedoUnitInfoScreen.visible = false
                counter = 1
                currentSet = 1
            }
            else if(counter < 100)
            {
                animator.animationCenterSpeedometer_START()
                animator.animationLeft_START()
                counter = 0
                currentSet = 1
                menuShown = false
            }
        }
    }

    function downPress() {
        if(vehicleInfo.vehicleSpeed === 0) {
            if (gameMenuVisible && pongGame.visible === false) {
                if (gameMenuCounter < gameMenu.getGameList() - 1) {
                    gameMenuCounter = gameMenuCounter + 1
                }
                else {
                    gameMenuCounter = 0
                }
            }
            else if (pongGame.visible) {
                pongGame.movePaddleDown()
            }
            else {
                counter = counter + 1
            }

            if(brakeBiasScreen.visible === true && brakeBiasObject.biasVal > 0 && brakeBiasObject.rearBrakeBias < 100)
            {
                counter = 3
                brakeBiasObject.biasVal -= 1
                brakeBiasObject.rearBrakeBias += 1
            }
            else if(brakeBiasObject.biasVal >= 100 || brakeBiasObject.rearBrakeBias >= 100)
            {
                counter = 3
            }
            else if(tractionControlScreen.visible === true && tract.tractionSwitch > 0)
            {
                counter = 4
                if(tract.tractionSwitch !== 1){
                    tract.tractionSwitch = tract.tractionSwitch - 1
                }
            }
            else if(launchAimScreen.visible === true && launchAimObj.launchAim > 0)
            {
                counter = 5
                if(launchAimObj.launchAim !== 1){
                    launchAimObj.launchAim = launchAimObj.launchAim - 1
                }
            }
            else if(antiLagScreen.visible === true && antiLagObj.antiLag > 0)
            {
                counter = 6
                if(antiLagObj.antiLag !== 1){
                    antiLagObj.antiLag = antiLagObj.antiLag - 1
                }
            }
            else if(counter > 2 && counter < 5)
            {
                currentSet = 2
            }
            else if(counter < 2)
            {
                currentSet = 1
            }
            else if(counter > 8 && currentSet === 4)
            {
                currentSet = 5
                counter = 9
            }
            else if(counter > 9 && currentSet === 5)
            {
                counter = 0
                currentSet = 1
            }
            else if(currentSet === 3 && counter === 103)
            {
                currentSet = 6
            }
            else if(currentSet === 6 && counter === 106)
            {
                counter = 100
                currentSet = 3
            }
            else if(counter > 5 && currentSet === 2)
            {
                counter = 6
                currentSet = 4
            }
        }
    }

    function upPress() {
        if(vehicleInfo.vehicleSpeed === 0) {
            if (gameMenuVisible && pongGame.visible === false) {
                if (gameMenuCounter === 0) {
                    gameMenuCounter = gameMenu.getGameList() - 1
                }
                else {
                    gameMenuCounter = gameMenuCounter - 1
                }
            }
            else if (pongGame.visible) {
                pongGame.movePaddleUp()
            }
            else {
                counter = counter - 1
            }

            if(brakeBiasScreen.visible === true && brakeBiasObject.biasVal < 100 && brakeBiasObject.rearBrakeBias > 0)
            {
                counter = 3
                brakeBiasObject.biasVal += 1
                brakeBiasObject.rearBrakeBias -= 1
            }
            else if(brakeBiasObject.biasVal >= 100 || brakeBiasObject.rearBrakeBias >= 100)
            {
                counter = 3
            }
            else if(tractionControlScreen.visible === true && tract.tractionSwitch < 11)
            {
                counter = 4
                if(tract.tractionSwitch !== 10){
                    tract.tractionSwitch = tract.tractionSwitch + 1
                }
            }
            else if(launchAimScreen.visible === true && launchAimObj.launchAim < 11)
            {
                counter = 5
                if(launchAimObj.launchAim !== 10){
                    launchAimObj.launchAim = launchAimObj.launchAim + 1
                }
            }
            else if(antiLagScreen.visible === true && antiLagObj.antiLag < 11)
            {
                counter = 6
                if(antiLagObj.antiLag !== 10){
                    antiLagObj.antiLag = antiLagObj.antiLag + 1
                }
            }
            else if(counter < 0)
            {
                currentSet = 5
                counter = 9
            }
            else if(counter == 2)
            {
                currentSet = 1
                counter = 2
            }
            else if(counter < 6 && currentSet === 4)
            {
                counter = 5
                currentSet = 2
            }
            else if(counter < 9 && currentSet === 5)
            {
                counter = 8
                currentSet = 4
            }
            else if(counter < 100 && currentSet === 3)
            {
                counter = 105
                currentSet = 6
            }
            else if(counter < 103 && currentSet === 6)
            {
                counter = 102
                currentSet = 3
            }
        }
    }
}
