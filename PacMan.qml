import QtQuick 2.15
import QtQuick.Controls 2.15

// Main Rectangle container instead of Window
Rectangle {
    id: pacmanGameRoot
    width: parent.width
    height: parent.height
    color: "black"

    // Signal to communicate back to main menu
    signal gameExited()

    property int cellSize: 20
    property int rows: 24
    property int cols: 40

    property var map: [
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1],
        [1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 1, 0, 1, 0, 1],
        [1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1],
        [1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1],
        [1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1],
        [1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1],
        [1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1],
        [1, 0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    ]

    // Player-related properties
    property int playerX: 1
    property int playerY: 1
    property int score: 0
    property bool gameOver: false
    property bool pacmanMouthOpen: true

    // Direction properties
    property int directionX: 0
    property int directionY: 0

    // Power mode properties
    property bool powerMode: false
    property int powerDuration: 5000  // 5 seconds
    property var eatenGhosts: [] // Track eaten ghosts for respawning
    property int lastDirectionX: 1  // Default: Moving right
    property int lastDirectionY: 0

    // Game state property
    property string gameState: "playing" // Values: "playing", "gameOver"

    ListModel {
        id: orbsVisible
    }

    ListModel {
        id: ghosts
    }

    // --- Reset function: reinitialize game state ---
    function resetGame() {
        gameOver = false;
        score = 0;
        playerX = 1;
        playerY = 1;
        directionX = 0;
        directionY = 0;
        lastDirectionX = 1;
        lastDirectionY = 0;
        pacmanMouthOpen = true;
        powerMode = false;
        gameState = "playing";

        // Repopulate the orbs
        orbsVisible.clear();
        for (let y = 0; y < rows; y++) {
            for (let x = 0; x < cols; x++) {
                if (map[y][x] === 0) {
                    orbsVisible.append({ "x": x, "y": y, "visible": true, "special": false });
                } else if (map[y][x] === 2) {
                    orbsVisible.append({ "x": x, "y": y, "visible": true, "special": true });
                }
            }
        }

        // Repopulate the ghosts
        ghosts.clear();
        ghosts.append({ "x": 9, "y": 5, "scared": false });
        ghosts.append({ "x": 5, "y": 9, "scared": false });
        ghosts.append({ "x": 3, "y": 3, "scared": false });
        ghosts.append({ "x": 10, "y": 15, "scared": false });
        ghosts.append({ "x": 20, "y": 15, "scared": false });
        ghosts.append({ "x": 25, "y": 20, "scared": false });
        ghosts.append({ "x": 35, "y": 10, "scared": false });
    }

    // Initialize game
    Component.onCompleted: {
        // Initialize orbs
        for (let y = 0; y < rows; y++) {
            for (let x = 0; x < cols; x++) {
                if (map[y][x] === 0) {
                    orbsVisible.append({ "x": x, "y": y, "visible": true, "special": false })
                } else if (map[y][x] === 2) {  // Special orb
                    orbsVisible.append({ "x": x, "y": y, "visible": true, "special": true })
                }
            }
        }

        // Initialize ghosts
        ghosts.append({ "x": 9, "y": 5, "scared": false })
        ghosts.append({ "x": 5, "y": 9, "scared": false })
        ghosts.append({ "x": 3, "y": 3, "scared": false })
        ghosts.append({ "x": 10, "y": 15, "scared": false })
        ghosts.append({ "x": 20, "y": 15, "scared": false })
        ghosts.append({ "x": 25, "y": 20, "scared": false })
        ghosts.append({ "x": 35, "y": 10, "scared": false })
    }

    function handleKeyPress(key) {
            if (gameState === "playing" && !gameOver) {
                // Movement logic for playing state
                let tempX = directionX
                let tempY = directionY

                switch (key) {
                    case "LEFT":
                        tempX = -1
                        tempY = 0
                        break
                    case "RIGHT":
                        tempX = 1
                        tempY = 0
                        break
                    case "UP":
                        tempX = 0
                        tempY = -1
                        break
                    case "DOWN":
                        tempX = 0
                        tempY = 1
                        break
                }

                let nextX = playerX + tempX
                let nextY = playerY + tempY
                if (nextX >= 0 && nextX < cols && nextY >= 0 && nextY < rows && map[nextY][nextX] !== 1) {
                    directionX = tempX
                    directionY = tempY
                }
            } else if (gameState === "gameOver") {
                // Handle game over screen key presses
                switch (key) {
                    case "LEFT":
                        gameExited() // Return to main menu
                        break
                    case "RIGHT":
                    case "UP":
                    case "DOWN":
                        resetGame() // Restart game
                        break
                }
            }
        }

    // --- Game Container --- //
    Rectangle {
        id: gameContainer
        visible: gameState === "playing"
        width: parent.width
        height: parent.height
        color: "black"
       // focus: true

        // Render the walls with a blue outline on a black background
        Repeater {
            model: rows * cols
            delegate: Rectangle {
                x: (index % cols) * cellSize
                y: Math.floor(index / cols) * cellSize
                width: cellSize
                height: cellSize
                // Change wall cells to have a blue border over a black fill
                color: map[Math.floor(index / cols)][index % cols] === 1 ? "#192464" : "black"
            }
        }

        // Render orbs (normal and special)
        Repeater {
            model: orbsVisible
            delegate: Rectangle {
                x: model.x * cellSize + cellSize / 4
                y: model.y * cellSize + cellSize / 4
                width: cellSize / 2
                height: cellSize / 2
                color: model.special ? "orange" : "white"
                visible: model.visible
            }
        }

        // Render Pac-Man with rotation based on last movement direction
        Image {
            id: player
            source: pacmanMouthOpen ? "assets/images/pacMan.png" : "assets/images/pacManClosed.png"
            x: playerX * cellSize
            y: playerY * cellSize
            width: cellSize
            height: cellSize

            transform: Rotation {
                origin.x: player.width / 2
                origin.y: player.height / 2
                angle: {
                    if (lastDirectionX === 1 && lastDirectionY === 0)
                        return 0;       // Moving right
                    else if (lastDirectionX === -1 && lastDirectionY === 0)
                        return 180;     // Moving left
                    else if (lastDirectionX === 0 && lastDirectionY === 1)
                        return 90;      // Moving down
                    else if (lastDirectionX === 0 && lastDirectionY === -1)
                        return 270;     // Moving up
                    else
                        return 0;
                }
            }
        }

        // Render ghosts (normal and scared mode)
        Repeater {
            model: ghosts
            delegate: Image {
                source: model.scared ? "assets/images/ghostScared.png" : "assets/images/ghost.png"
                x: model.x * cellSize
                y: model.y * cellSize
                width: cellSize
                height: cellSize
            }
        }

        // Pac-Man movement logic
        Timer {
            interval: 200
            repeat: true
            running: gameState === "playing" && !gameOver
            onTriggered: {
                if (gameOver) return;

                // Toggle mouth state for animation
                pacmanMouthOpen = !pacmanMouthOpen;

                let newX = playerX + directionX;
                let newY = playerY + directionY;

                if (newX >= 0 && newX < cols && newY >= 0 && newY < rows && map[newY][newX] !== 1) {
                    playerX = newX;
                    playerY = newY;
                    lastDirectionX = directionX;
                    lastDirectionY = directionY;
                } else {
                    let lastX = playerX + lastDirectionX;
                    let lastY = playerY + lastDirectionY;
                    if (lastX >= 0 && lastX < cols && lastY >= 0 && lastY < rows && map[lastY][lastX] !== 1) {
                        playerX = lastX;
                        playerY = lastY;
                    }
                }

                // Check for ghost collision
                for (let i = 0; i < ghosts.count; i++) {
                    let ghost = ghosts.get(i);
                    if (ghost.x === playerX && ghost.y === playerY) {
                        if (powerMode) {
                            eatenGhosts.push(i);
                            ghosts.setProperty(i, "x", -1);
                            ghosts.setProperty(i, "y", -1);
                            ghosts.setProperty(i, "scared", false);
                        } else {
                            gameOver = true;
                            gameState = "gameOver";
                            //gameOverScreen.forceActiveFocus();
                            return;
                        }
                    }
                }

                // Check for orb collision
                for (let j = 0; j < orbsVisible.count; j++) {
                    let orb = orbsVisible.get(j);
                    if (orb.x === playerX && orb.y === playerY && orb.visible) {
                        orbsVisible.setProperty(j, "visible", false);
                        score++;
                        if (orb.special) {
                            powerMode = true;
                            for (let i = 0; i < ghosts.count; i++) {
                                ghosts.setProperty(i, "scared", true);
                            }
                            powerTimer.restart();
                        }
                    }
                }
            }
        }

        // Timer for power mode
        Timer {
            id: powerTimer
            interval: powerDuration
            onTriggered: {
                powerMode = false;
                for (let i = 0; i < ghosts.count; i++) {
                    ghosts.setProperty(i, "scared", false);
                }

                for (let i = 0; i < eatenGhosts.length; i++) {
                    let ghostIndex = eatenGhosts[i];
                    ghosts.setProperty(ghostIndex, "x", 20); // Respawn position
                    ghosts.setProperty(ghostIndex, "y", 13);
                }
                eatenGhosts = [];
            }
        }

        // Ghost movement logic
        Timer {
            interval: 500
            repeat: true
            running: gameState === "playing" && !gameOver
            onTriggered: {
                if (gameOver) return;

                for (let i = 0; i < ghosts.count; i++) {
                    let ghost = ghosts.get(i);
                    let possibleDirections = [];
                    let newX, newY;

                    if (ghost.x > 0 && map[ghost.y][ghost.x - 1] !== 1)
                        possibleDirections.push({x: ghost.x - 1, y: ghost.y});
                    if (ghost.x < cols - 1 && map[ghost.y][ghost.x + 1] !== 1)
                        possibleDirections.push({x: ghost.x + 1, y: ghost.y});
                    if (ghost.y > 0 && map[ghost.y - 1][ghost.x] !== 1)
                        possibleDirections.push({x: ghost.x, y: ghost.y - 1});
                    if (ghost.y < rows - 1 && map[ghost.y + 1][ghost.x] !== 1)
                        possibleDirections.push({x: ghost.x, y: ghost.y + 1});

                    if (possibleDirections.length > 0) {
                        let rand = Math.floor(Math.random() * possibleDirections.length);
                        newX = possibleDirections[rand].x;
                        newY = possibleDirections[rand].y;
                        ghosts.setProperty(i, "x", newX);
                        ghosts.setProperty(i, "y", newY);
                    }

                    if (ghost.x === playerX && ghost.y === playerY) {
                        if (powerMode) {
                            eatenGhosts.push({ x: ghost.x, y: ghost.y });
                            ghosts.setProperty(i, "x", 9);
                            ghosts.setProperty(i, "y", 9);
                            ghosts.setProperty(i, "scared", false);
                        } else {
                            gameOver = true;
                            gameState = "gameOver";
                            //gameOverScreen.forceActiveFocus();
                            return;
                        }
                    }
                }
            }
        }
    }

    // --- Game Over Screen --- //
    Rectangle {
        id: gameOverScreen
        visible: gameState === "gameOver" || score >= 476
        width: parent.width
        height: parent.height
        color: "black"
        //focus: true



        Image {
            id: endScreenImage
            source: "assets/images/endScreen.png"
            width: 280
            height: 280
            anchors.centerIn: parent
        }

        Text
        {
            id: instructionTextRight
            text: "PRESS RIGHT TO PLAY AGAIN"
            color: "white"
            font.bold: true
            font.pixelSize: 18

            anchors {
                horizontalCenter: endScreenImage.horizontalCenter
                top: endScreenImage.bottom
                margins: 5
            }
        }

        Text
        {
            id: instructionTextLeft
            text: "PRESS LEFT TO QUIT"
            color: "white"
            font.bold: true
            font.pixelSize: 18

            anchors {
                horizontalCenter: endScreenImage.horizontalCenter
                top: instructionTextRight.bottom
                margins: 5
            }
        }

        Text {
            id: scoreText
            text: "Final Score: " + score
            color: "white"
            font.bold: true
            font.pixelSize: 18
            anchors {
                horizontalCenter: endScreenImage.horizontalCenter
                top: instructionTextLeft.bottom
                margins: 5
            }
        }
    }
}
