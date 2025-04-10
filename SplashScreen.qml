import QtQuick

Item {
    id: splashScreen
    visible: true
    anchors.fill: parent
    z: 10

    Rectangle {
        anchors.fill: parent
        color: "black"

        Image {
            source: "assets/images/teamlogo.png"
            anchors.centerIn: parent
        }
    }


 }
