import QtQuick
import QtQuick.Layouts

Item {
    property int gameList: 3 // Increased from 2 to 3 to include Flappy Bird
    id: gameMenuRoot

    anchors {
        top: parent.top
        bottom: parent.bottom
        horizontalCenter: parent.horizontalCenter
    }

    Text {
        text: "⯅"
        width: 20
        font.pixelSize: 20
        font.bold: true
        color: "#4b4b4b"
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
    }

    Text {
        text: "⯆"
        width: 20
        font.pixelSize: 20
        font.bold: true
        color: "#4b4b4b"
        anchors {
            margins: -5
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
    }

    Loader {
        id: gameMenuLoader
        sourceComponent: gameMenuComponent
    }

    Component {
        id: gameMenuComponent

        Rectangle {
            id: gameMenuBackground
            color: "#1E1E1E"
            radius: 20
            anchors.fill: parent

            GridLayout {
                id: layoutContainer
                width: parent.width
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }

                columns: 1
                rows: gameList
                rowSpacing: 5

                Rectangle {
                    id: pongGame
                    height: 130
                    width: 290
                    Layout.topMargin: 25
                    Layout.rightMargin: 5
                    Layout.leftMargin: 5
                    radius: 20
                    color: (gameMenuCounter % 3 === 0) ? "#00a8ff" : "white"

                    Text {
                        text: qsTr("Pong")
                        color: (gameMenuCounter % 3 === 0) ? "white" : "black"
                        anchors.centerIn: parent
                        font.pixelSize: 30
                        font.bold: true
                    }
                }

                Rectangle {
                    id: pacmanGame
                    height: 130
                    width: 290
                    Layout.rightMargin: 5
                    Layout.leftMargin: 5
                    radius: 20
                    color: (gameMenuCounter % 3 === 1) ? "#00a8ff" : "white"

                    Text {
                        text: qsTr("Pacman")
                        color: (gameMenuCounter % 3 === 1) ? "white" : "black"
                        anchors.centerIn: parent
                        font.pixelSize: 30
                        font.bold: true
                    }
                }

                Rectangle {
                    id: flappyBirdGame
                    height: 130
                    width: 290
                    Layout.rightMargin: 5
                    Layout.leftMargin: 5
                    radius: 20
                    color: (gameMenuCounter % 3 === 2) ? "#00a8ff" : "white"

                    Text {
                        text: qsTr("Flappy Bird")
                        color: (gameMenuCounter % 3 === 2) ? "white" : "black"
                        anchors.centerIn: parent
                        font.pixelSize: 30
                        font.bold: true
                    }
                }
            }
        }
    }

    function getGameList() {
        return gameList
    }
}
