import QtQuick

Item {

    function rightPress() {
        if (gameMenuVisible &&  gameMenuRect.x === rootWindow.width - gameMenuRect.width - 15) {
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
                updateBias(driver, (100 - brakeBiasObject.rearBrakeBias))
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
                updateTraction(driver, tract.tractionSwitch)
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
        else if(columnBar.x > 0 && counter === 0)
        {
            currentSet = 3
            counter = 6
        }
        else if(currentSet === 3)
        {
            loadNewProfile(counter - 6)
            animator.animationCenterSpeedometer_START()
            animator.animationLeft_START()

            statusMessage.text = "Profile Loaded:  " + (driver + 1)
            statusImage.source = "assets/images/INFO.png"
            statusMessage.font.pixelSize = 14
            animator.statusUpdateAnimation_START()

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
        else if(counter === 1)
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
            counter = 9
        }
        else if(engineInfoScreen.visible === true && counter === 9)
        {
            extraInfoWidgets.visible = true
        }
        else if(counter === 2 && lc_Status !== 1)
        {
            lc_Status = 1
            canManager.updatePayload(4, lc_Status)
            animator.animationCenterSpeedometer_START()
            animator.animationLeft_START()

            statusMessage.text = "Launch Control: Active"
            statusImage.source = "assets/images/LC.png"
            statusMessage.font.pixelSize = 15
            animator.statusUpdateAnimation_START()

            counter = 0
            currentSet = 1
            launchControlImage.visible = true
            menuShown = false
        }
        else if(counter === 2 && lc_Status !== 0)
        {
            lc_Status = 0
            canManager.updatePayload(4, lc_Status)
            animator.animationCenterSpeedometer_START()
            animator.animationLeft_START()

            statusMessage.text = "Launch Control: Inactive"
            statusImage.source = "assets/images/LC.png"
            statusMessage.font.pixelSize = 14
            animator.statusUpdateAnimation_START()

            counter = 0
            currentSet = 1
            launchControlImage.visible = false
            menuShown = false
        }
    }

    function leftPress() {
        if(columnBar.x < 0){
            if (!gameMenuVisible && menuShown === false)
            {
                menuShown = true
                gameMenuVisible = true
                gameMenu.x = rootWindow.width
                animator.animationLeftSpeedometer_START()
                animator.gameMenuAnimationLeft_START()
            }
            else if(gameMenuVisible && gameMenu.x === rootWindow.width - gameMenu.width - 15)
            {
                if (gameMenuCounter === 0)
                {
                    console.log("Launching Pong")
                }
                else if (gameMenuCounter === 1)
                {
                    console.log("Launching Pacman")
                }
            }
        }
        else if(counter >= 0 && counter <= 4 && engineInfoScreen.visible === false &&
                brakeBiasScreen.visible === false && tractionControlScreen.visible === false)
        {
            animator.animationCenterSpeedometer_START()
            animator.animationLeft_START()
            counter = 0
            currentSet = 1
            menuShown = false
        }
        else if(counter === 6 || counter === 7 || counter === 8 && currentSet === 3) {
            currentSet = 1
            counter = 0
            animator.animationRight_START()
        }
        else if(counter === 3 && brakeBiasScreen.visible === true)
        {
            if(brakeBiasObject.rearBrakeBias !== (100 - JSON.biasVal)) {
                updateBias(driver, (100 - brakeBiasObject.rearBrakeBias))
                brakeBiasScreen.visible = false
                animator.animationRight_START()
                animator.animationRightSpeedometer_START()

                statusMessage.text = "Setting Updated"
                statusImage.source = "assets/images/INFO.png"
                statusMessage.font.pixelSize = 20
                animator.statusUpdateAnimation_START()

                counter = 3
                currentSet = 2
            }
            else {
                brakeBiasScreen.visible = false
                animator.animationRight_START()
                animator.animationRightSpeedometer_START()

                counter = 3
                currentSet = 2
            }
        }
        else if(counter === 4 && tractionControlScreen.visible === true)
        {
            if(tract.tractionSwitch !== JSON.tractionSwitch)
            {
                updateTraction(driver, tract.tractionSwitch)
                animator.animationRight_START()
                animator.animationRightSpeedometer_START()

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
                animator.animationRightSpeedometer_START()
                animator.animationRight_START()

                counter = 4
                currentSet = 2
                tractionControlScreen.visible = false
            }
        }
        else if(extraInfoWidgets.visible === true)
        {
            counter = 9
            extraInfoWidgets.visible = false
        }
        else if (counter === 9 && engineInfoScreen.visible === true)
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
        else if(counter > 9 && engineInfoScreen.visible === true)
        {
            counter = counter - 1
        }
    }

    function downPress() {
        if (gameMenuVisible) {
            if (gameMenuCounter < gameMenu.getGameList() - 1) {
                gameMenuCounter = gameMenuCounter + 1
            }
            else {
                gameMenuCounter = 0
            }
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
        else if(engineInfoScreen.visible === true)
        {
            counter = 11
        }
        else if(tractionControlScreen.visible === true && tract.tractionSwitch > 0)
        {
            counter = 4
            if(tract.tractionSwitch !== 1){
                tract.tractionSwitch = tract.tractionSwitch - 1
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
        else if(counter > 11 && currentSet === 4)
        {
            currentSet = 5
            counter = 12
        }
        else if(counter > 12 && currentSet === 5)
        {
            counter = 0
            currentSet = 1
        }

        else if(currentSet === 3 && counter > 8)
        {
            counter = 6
        }
        else if(counter > 5 && currentSet === 2)
        {
            counter = 9
            currentSet = 4
        }
    }

    function upPress() {
        if (gameMenuVisible) {
            if (gameMenuCounter === 0) {
                gameMenuCounter = gameMenu.getGameList() - 1
            }
            else {
                gameMenuCounter = gameMenuCounter - 1
            }
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
        else if(counter < 0)
        {
            currentSet = 5
            counter = 12
        }
        else if(counter == 2)
        {
            currentSet = 1
            counter = 2
        }
        else if(counter < 9 && currentSet === 4)
        {
            counter = 5
            currentSet = 2
        }
        else if(counter < 12 && currentSet === 5)
        {
            counter = 11
            currentSet = 4
        }

        else if(counter < 6 && currentSet === 3)
        {
            counter = 8
        }
    }
}
