import QtQuick
import QtQuick.Layouts

Rectangle {
    id: pongRoot
    color: "#1E1E1E"
    radius: 20

    Component.onCompleted: {
        playerScore = 0
        aiScore = 0

        gameTimer.start()
        ballTimer.start()
    }

    property int playerScore: 0
    property int aiScore: 0
    property real ballSpeedX: -2
    property real ballSpeedY: 1
    property real maxBallSpeedX: 7
    property real maxBallSpeedY: 3
    property int paddleSpeed: 25
    property int aiPaddleSpeed: 6
    property int minimumPaddleMovement: 3

    Text {
        text: aiScore + " : " + playerScore
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

        Rectangle {
            id: leftPaddle
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
                    var paddleCenter = leftPaddle.y + leftPaddle.height/2
                    var distance = ball.y - paddleCenter

                    if (Math.abs(distance) > minimumPaddleMovement) {
                        if (distance > 0) {
                            leftPaddle.y = Math.min(gameArea.height - leftPaddle.height, leftPaddle.y + aiPaddleSpeed)
                        } else {
                            leftPaddle.y = Math.max(0, leftPaddle.y - aiPaddleSpeed)
                        }
                    }
                }
            }
        }

        Rectangle {
            id: rightPaddle
            width: 15
            height: 100
            color: "white"
            x: parent.width - width - 20
            y: (parent.height - height) / 2
        }

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
                    ball.x += ballSpeedX
                    ball.y += ballSpeedY

                    if (ball.y <= 0 || ball.y + ball.height >= gameArea.height) {
                        ballSpeedY = -ballSpeedY * 1.02
                        ballSpeedY = Math.max(Math.min(ballSpeedY, maxBallSpeedY), -maxBallSpeedY)
                    }

                    if (ball.x <= leftPaddle.x + leftPaddle.width && ball.y + ball.height >= leftPaddle.y && ball.y <= leftPaddle.y + leftPaddle.height) {
                        ballSpeedX = Math.min(Math.abs(ballSpeedX) * 1.1, maxBallSpeedX)
                        ballSpeedY += (ball.y - (leftPaddle.y + leftPaddle.height/2)) * 0.3
                        ballSpeedY = Math.max(Math.min(ballSpeedY, maxBallSpeedY), -maxBallSpeedY)
                    }

                    if (ball.x + ball.width >= rightPaddle.x && ball.y + ball.height >= rightPaddle.y && ball.y <= rightPaddle.y + rightPaddle.height) {
                        ballSpeedX = -Math.min(Math.abs(ballSpeedX) * 1.1, maxBallSpeedX)
                        ballSpeedY += (ball.y - (rightPaddle.y + rightPaddle.height/2)) * 0.3
                        ballSpeedY = Math.max(Math.min(ballSpeedY, maxBallSpeedY), -maxBallSpeedY)
                    }

                    if (ball.x <= 0) {
                        playerScore++
                        resetBall()
                    } else if (ball.x + ball.width >= gameArea.width) {
                        aiScore++
                        resetBall()
                    }
                }
            }
        }
    }

    function resetBall() {
        ball.x = (gameArea.width - ball.width) / 2
        ball.y = (gameArea.height - ball.height) / 2

        ballSpeedX = Math.random() > 0.5 ? -2 : 2
        ballSpeedY = Math.random() * 2 - 1

        ballTimer.restart()
    }

    function movePaddleUp() {
        rightPaddle.y = Math.max(0, rightPaddle.y - paddleSpeed)
    }

    function movePaddleDown() {
        rightPaddle.y = Math.min(gameArea.height - rightPaddle.height, rightPaddle.y + paddleSpeed)
    }

    function fullReset() {
        playerScore = 0
        aiScore = 0
        resetBall()
        rightPaddle.y = (gameArea.height - rightPaddle.height) / 2
    }
}
