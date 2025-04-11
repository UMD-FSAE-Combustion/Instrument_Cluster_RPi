import QtQuick

Item {
    id: loaderRoot
    anchors.fill: parent

    property bool loadingComplete: false

    Image {
        id: loadingImage
        anchors.centerIn: parent
        source: "assets/images/teamlogo.png"
        visible: !loadingComplete

        Rectangle {
            id: dotContainer
            width: 120
            height: 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: loadingImage.bottom
            anchors.topMargin: 10
            color: "transparent"

            Rectangle {
                id: dot_1
                width: 20
                height: 20
                color: "#FFCB05"
                radius: 100
                anchors.left: parent.left
                SequentialAnimation {
                    running: true
                    loops: Animation.Infinite
                    ScaleAnimator {
                        target: dot_1
                        from: 1
                        to: 0
                        duration: 1840
                    }
                    ScaleAnimator {
                        target: dot_1
                        from: 0
                        to: 1
                        duration: 1840
                    }
                }
            }

            Rectangle {
                id: dot_2
                width: 20
                height: 20
                color: "#FFCB05"
                radius: 100
                anchors.left: dot_1.right
                anchors.leftMargin: 10
                SequentialAnimation {
                    running: true
                    PauseAnimation {
                        duration: 120
                    }
                    SequentialAnimation {
                        loops: Animation.Infinite
                        ScaleAnimator {
                            target: dot_2
                            from: 1
                            to: 0
                            duration: 1840
                        }
                        ScaleAnimator {
                            target: dot_2
                            from: 0
                            to: 1
                            duration: 1840
                        }
                    }
                }
            }

            Rectangle {
                id: dot_3
                width: 20
                height: 20
                color: "#FFCB05"
                radius: 100
                anchors.left: dot_2.right
                anchors.leftMargin: 10
                SequentialAnimation {
                    running: true
                    PauseAnimation {
                        duration: 240
                    }
                    SequentialAnimation {
                        loops: Animation.Infinite
                        ScaleAnimator {
                            target: dot_3
                            from: 1
                            to: 0
                            duration: 1840
                        }
                        ScaleAnimator {
                            target: dot_3
                            from: 0
                            to: 1
                            duration: 1840
                        }
                    }
                }
            }

            Rectangle {
                id: dot_4
                width: 20
                height: 20
                color: "#FFCB05"
                radius: 100
                anchors.left: dot_3.right
                anchors.leftMargin: 10
                SequentialAnimation {
                    running: true
                    PauseAnimation {
                        duration: 360
                    }
                    SequentialAnimation {
                        loops: Animation.Infinite
                        ScaleAnimator {
                            target: dot_4
                            from: 1
                            to: 0
                            duration: 1840
                        }
                        ScaleAnimator {
                            target: dot_4
                            from: 0
                            to: 1
                            duration: 1840
                        }
                    }
                }
            }
        }
    }
}
