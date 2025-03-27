import QtQuick
import QtQuick.Layouts

Rectangle {
    id: flappyRoot
    color: "#1E1E1E"
    radius: 20

    // Signal to communicate back to main menu
    signal gameExited()

    // Game properties
    property int score: 0
    property int highScore: 0
    property bool gameOver: false
    property int gravity: 1
    property int jumpForce: -10
    property int pipeSpeed: 3
    property int pipeWidth: 60
    property int pipeGap: 150
    property int groundHeight: 30
    property int birdSize: 30
    property int birdVelocity: 0
    property var pipes: []
    property int pipeSpawnTimer: 0
    property int pipeSpawnInterval: 1500
    property string gameState: "start" // Values: "start", "playing", "gameOver"

    Component.onCompleted: {
        resetGame()
    }

    // Text display for score
    Text {
        text: score
        color: "white"
        font.pixelSize: 40
        font.bold: true
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: 10
        }
        z: 10
    }

    // Game area
    Rectangle {
        id: gameArea
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            margins: 10
        }
        color: "#87CEEB" // Sky blue
        clip: true

        // Ground
        Rectangle {
            id: ground
            width: parent.width
            height: groundHeight
            color: "#8B4513" // Brown
            anchors.bottom: parent.bottom
        }

        // Bird
        Image {
            id: bird
            source: "assets/images/bird.png"
            width: birdSize
            height: birdSize
            x: parent.width / 3
            y: parent.height / 2 - height / 2
            z: 2

            // Bird rotation based on velocity
            rotation: Math.min(Math.max(birdVelocity * 2, -30), 90)

            // Wing flap animation
            SequentialAnimation {
                id: flapAnimation
                running: gameState === "playing" && !gameOver
                loops: Animation.Infinite
                PropertyAnimation {
                    target: bird
                    property: "scale"
                    from: 1.0
                    to: 0.8
                    duration: 200
                }
                PropertyAnimation {
                    target: bird
                    property: "scale"
                    from: 0.8
                    to: 1.0
                    duration: 200
                }
            }
        }

        // Start message
        Text {
            id: startMessage
            text: "Tap to Start"
            color: "white"
            font.pixelSize: 30
            font.bold: true
            anchors.centerIn: parent
            visible: gameState === "start"
        }

        // Game Over display
        Rectangle {
            id: gameOverScreen
            width: parent.width * 0.8
            height: parent.height * 0.4
            color: "black"
            opacity: 0.8
            radius: 10
            anchors.centerIn: parent
            visible: gameState === "gameOver"

            Column {
                anchors.centerIn: parent
                spacing: 10

                Text {
                    text: "Game Over"
                    color: "red"
                    font.pixelSize: 30
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Score: " + score
                    color: "white"
                    font.pixelSize: 25
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "High Score: " + highScore
                    color: "white"
                    font.pixelSize: 25
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Tap to Restart"
                    color: "yellow"
                    font.pixelSize: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }

    // Main game loop
    Timer {
        id: gameTimer
        interval: 16 // ~60 FPS
        running: gameState === "playing" && !gameOver
        repeat: true
        onTriggered: {
            updateGame()
        }
    }

    // Pipe spawning timer
    Timer {
        id: pipeCreationTimer
        interval: pipeSpawnInterval
        running: gameState === "playing" && !gameOver
        repeat: true
        onTriggered: {
            createPipe()
        }
    }

    // Mouse/touch area for game input
    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (gameState === "start") {
                startGame()
            } else if (gameState === "gameOver") {
                resetGame()
            } else if (gameState === "playing") {
                jump()
            }
        }
    }

    // Handle key presses
    function handleKeyPress(key) {
        if (key === "UP" || key === "SPACE") {
            if (gameState === "start") {
                startGame()
            } else if (gameState === "gameOver") {
                resetGame()
            } else if (gameState === "playing") {
                jump()
            }
        } else if (key === "ESCAPE" || key === "BACK") {
            gameExited()
        }
    }

    // Jump function
    function jump() {
        birdVelocity = jumpForce
    }

    // Start game
    function startGame() {
        gameState = "playing"
        createPipe()
        gameTimer.restart()
        pipeCreationTimer.restart()
    }

    // Reset game state
    function resetGame() {
        // Clear existing pipes
        for (let i = 0; i < pipes.length; i++) {
            if (pipes[i].topPipe) {
                pipes[i].topPipe.destroy()
            }
            if (pipes[i].bottomPipe) {
                pipes[i].bottomPipe.destroy()
            }
        }
        pipes = []

        // Reset game variables
        birdVelocity = 0
        score = 0
        gameOver = false
        gameState = "start"

        // Reset bird position
        bird.y = gameArea.height / 2 - bird.height / 2
        bird.rotation = 0
    }

    // Create a new pipe pair
    function createPipe() {
        let pipeY = Math.random() * (gameArea.height - pipeGap - groundHeight - 60) + 30

        // Top pipe
        let topPipe = Qt.createQmlObject(`
            import QtQuick
            Rectangle {
                width: ${pipeWidth}
                color: "#006400" // Dark green
                x: ${gameArea.width}
                y: 0
                height: ${pipeY}
            }`, gameArea, "topPipe")

        // Bottom pipe
        let bottomPipe = Qt.createQmlObject(`
            import QtQuick
            Rectangle {
                width: ${pipeWidth}
                color: "#006400" // Dark green
                x: ${gameArea.width}
                y: ${pipeY + pipeGap}
                height: ${gameArea.height - pipeY - pipeGap - groundHeight}
            }`, gameArea, "bottomPipe")

        pipes.push({
            topPipe: topPipe,
            bottomPipe: bottomPipe,
            passed: false
        })
    }

    // Main update function
    function updateGame() {
        // Update bird position
        birdVelocity += gravity
        bird.y += birdVelocity

        // Check collision with ground
        if (bird.y + bird.height > gameArea.height - groundHeight) {
            bird.y = gameArea.height - bird.height - groundHeight
            gameOver = true
            gameState = "gameOver"
            if (score > highScore) {
                highScore = score
            }
            return
        }

        // Check collision with ceiling
        if (bird.y < 0) {
            bird.y = 0
            birdVelocity = 0
        }

        // Update pipes and check collisions
        for (let i = pipes.length - 1; i >= 0; i--) {
            // Move pipes
            pipes[i].topPipe.x -= pipeSpeed
            pipes[i].bottomPipe.x -= pipeSpeed

            // Score point when passing pipe
            if (!pipes[i].passed && pipes[i].topPipe.x + pipeWidth < bird.x) {
                pipes[i].passed = true
                score++
            }

            // Check collisions
            if (checkCollision(bird, pipes[i].topPipe) ||
                checkCollision(bird, pipes[i].bottomPipe)) {
                gameOver = true
                gameState = "gameOver"
                if (score > highScore) {
                    highScore = score
                }
                return
            }

            // Remove pipes that have gone off screen
            if (pipes[i].topPipe.x + pipeWidth < 0) {
                pipes[i].topPipe.destroy()
                pipes[i].bottomPipe.destroy()
                pipes.splice(i, 1)
            }
        }
    }

    // Check collision between bird and pipe
    function checkCollision(birdItem, pipeItem) {
        return birdItem.x < pipeItem.x + pipeWidth &&
               birdItem.x + birdItem.width > pipeItem.x &&
               birdItem.y < pipeItem.y + pipeItem.height &&
               birdItem.y + birdItem.height > pipeItem.y
    }
}
