import QtQuick

Item {
    id: splashScreen
    visible: true
    anchors.fill: parent

    Rectangle {
        anchors.fill: parent
        color: "black"

        Image {
            source: "assets/images/teamlogo.png"
            anchors.centerIn: parent
        }
    }


 }
