import QtQuick
import QtQuick.Layouts

Rectangle {
    id: pongRoot
    color: "#1E1E1E"
    radius: 20


    // Score variables
    property int playerScore: 0
    property int computerScore: 0

    // Ball variables
    property real ballSpeedHorizontal: -2
    property real ballSpeedVertical: 1
    property real maxBallSpeedHorizontal: 7
    property real maxBallSpeedVertical: 5


    // Paddle variables
    property int paddleSpeed: 10
    property int aiPaddleSpeed: 8
    property int minimumPaddleMovement: 3

    // Initialize game when it loads
    Component.onCompleted: {
        playerScore = 0
        computerScore = 0

        gameTimer.start()
        ballTimer.start()
    }


    // Score text
    Text {
        text: computerScore + " : " + playerScore
        color: "white"
        font.pixelSize: 30
        font.bold: true
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: 10
        }
    }

    Rectangle {
        id: gameArea
        anchors {
            top: parent.top
            topMargin: 50
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            margins: 10
        }
        color: "black"

        // Computer paddle component
        Rectangle {
            id: computerPaddle
            width: 15
            height: 100
            color: "white"
            x: 20
            y: (parent.height - height) / 2

            Timer {
                id: gameTimer
                interval: 50
                running: false
                repeat: true
                onTriggered: {
                    var paddleCenter = computerPaddle.y + computerPaddle.height/2
                    var distance = ball.y - paddleCenter

                    if (Math.abs(distance) > minimumPaddleMovement) {
                        if (distance > 0) {
                            computerPaddle.y = Math.min(gameArea.height - computerPaddle.height, computerPaddle.y + aiPaddleSpeed)
                        } else {
                            computerPaddle.y = Math.max(0, computerPaddle.y - aiPaddleSpeed)
                        }
                    }
                }
            }
        }

        // Player paddle component
        Rectangle {
            id: playerPaddle
            width: 15
            height: 100
            color: "white"
            x: parent.width - width - 20
            y: (parent.height - height) / 2
        }

        // Ball component
        Rectangle {
            id: ball
            width: 15
            height: 15
            color: "white"
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2

            Timer {
                id: ballTimer
                interval: 16
                running: false
                repeat: true
                onTriggered: {
                    ball.x += ballspeedHorizontal
                    ball.y += ballSpeedVertical

                    if (ball.y <= 0 || ball.y + ball.height >= gameArea.height) {
                        ballSpeedVertical = -ballSpeedVertical * 1.02
                        ballSpeedVertical = Math.max(Math.min(ballSpeedVertical, maxBallSpeedVertical), -maxBallSpeedVertical)
                    }

                    if (ball.x <= computerPaddle.x + computerPaddle.width && ball.y + ball.height >= computerPaddle.y && ball.y <= computerPaddle.y + computerPaddle.height) {
                        ballspeedHorizontal = Math.min(Math.abs(ballspeedHorizontal) * 1.1, maxBallSpeedHorizontal)
                        ballSpeedVertical += (ball.y - (computerPaddle.y + computerPaddle.height/2)) * 0.3
                        ballSpeedVertical = Math.max(Math.min(ballSpeedVertical, maxBallSpeedVertical), -maxBallSpeedVertical)
                    }

                    if (ball.x + ball.width >= playerPaddle.x && ball.y + ball.height >= playerPaddle.y && ball.y <= playerPaddle.y + playerPaddle.height) {
                        ballspeedHorizontal = -Math.min(Math.abs(ballspeedHorizontal) * 1.1, maxBallSpeedHorizontal)
                        ballSpeedVertical += (ball.y - (playerPaddle.y + playerPaddle.height/2)) * 0.3
                        ballSpeedVertical = Math.max(Math.min(ballSpeedVertical, maxBallSpeedVertical), -maxBallSpeedVertical)
                    }

                    if (ball.x <= 0) {
                        playerScore++
                        resetBall()
                    } else if (ball.x + ball.width >= gameArea.width) {
                        computerScore++
                        resetBall()
                    }
                }
            }
        }
    }

    // Function to reset the position of the ball after each score
    function resetBall() {
        ball.x = (gameArea.width - ball.width) / 2
        ball.y = (gameArea.height - ball.height) / 2

        ballspeedHorizontal = Math.random() > 0.5 ? -2 : 2
        ballSpeedVertical = Math.random() * 2 - 1

        ballTimer.restart()
    }

    // Moves the player controlled paddle up 
    function movePaddleUp() {
        playerPaddle.y = Math.max(0, playerPaddle.y - paddleSpeed)
    }

    // Moves the player controlled paddle down
    function movePaddleDown() {
        playerPaddle.y = Math.min(gameArea.height - playerPaddle.height, playerPaddle.y + paddleSpeed)
    }

    // Fully resets the game(used on close) 
    function fullReset() {
        playerScore = 0
        computerScore = 0
        resetBall()
        playerPaddle.y = (gameArea.height - playerPaddle.height) / 2
    }
}
