import QtQuick

Item {
    id: splashScreen
    visible: true
    anchors.fill: parent

    AnimatedImage {
        source: "assets/images/loadingScreen.gif"
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        playing: true // Start animation
    }
 }
