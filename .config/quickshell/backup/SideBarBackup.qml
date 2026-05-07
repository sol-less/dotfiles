import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Services.Pipewire

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "../assets/color"

PopupWindow {
    id: popup
    property alias anchorWindow: popupAnchor.window
    property bool isOpen: false
    property int page: 0

    property var player: {
        for (let p of Mpris.players.values) {
            if (p.identity.toLowerCase() === "spotify" || p.desktopEntry === "spotify") {
                return p;
            }
        }
        return null;
    }
    property color activeColor: Colors.background
    property bool anyHover: prev.containsMouse || play.containsMouse || next.containsMouse

    readonly property int mprisHeight: 220
    readonly property int systemHeight: 400

    function formatTime(s) {
        if (!s || isNaN(s)) return "0:00";
        let mins = Math.floor(s / 60);
        let secs = Math.floor(s % 60);
        return mins + ":" + (secs < 10 ? "0" : "") + secs;
    }

    Timer {
        interval: 1000
        repeat: true
        running: player && player.playbackState == MprisPlaybackState.Playing
        onTriggered: player.positionChanged()
    }

    visible: closeTime.running || isOpen
    width: 450
    height: 400
    color: "transparent"

    anchor {
        id: popupAnchor
        rect {
            x: anchorWindow ? anchorWindow.width : 0
            y: (anchorWindow ? anchorWindow.height / 2 : 0) - (systemHeight / 2)
        }
    }


    function toggle() {
        if (!isOpen) isOpen = true;
        else { closeTime.start(); isOpen = false; }
    }

    Timer { id: closeTime; interval: 505 }

    Rectangle {
        id: popupContainer
        anchors.left: parent.left

        height: contentStack.currentIndex === 0 ? mprisHeight : parent.height
        width: popup.isOpen ? 450 : 0
        radius: 12

        y: (parent.height - height) / 2

        Behavior on height {
            NumberAnimation { duration: 500; easing.type: Easing.OutQuint }
        }

        clip: true
        color: Colors.background

        Behavior on width { NumberAnimation { duration: 500; easing.type: Easing.OutQuint } }
        
        transform: Translate {
            x: popup.isOpen ? -10 : -30
            Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.OutQuint } }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 15
            spacing: 10
            opacity: popup.isOpen ? 1 : 0

            Behavior on opacity {
                NumberAnimation { duration: 250 }
            }

            SwipeView {
                id: contentStack
                currentIndex: popup.page

                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                onCurrentIndexChanged: {
                    if (popup.page !== currentIndex) {
                        popup.page = currentIndex;
                    }
                }

                opacity: popup.isOpen ? 1 : 0

                Behavior on opacity {
                    NumberAnimation { duration: 250 }
                } 

                // MPRIS (done m8)
                ColumnLayout {
                    ColumnLayout {
                        anchors.fill: parent
                        width: parent.width - 40
                        spacing: 20

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 80
                            
                            color: Qt.alpha(Colors.primary, 0.2)

                            Column {
                                anchors.centerIn: parent
                                width: parent.width - 10
                                spacing: 4

                                Text {
                                    width: parent.width
                                    text: player ? player.metadata["xesam:title"] : "No Media Playing"
                                    color: Colors.primary
                                    font.family: "Google Sans"
                                    font.bold: true
                                    font.pixelSize: 18
                                    horizontalAlignment: Text.AlignHCenter
                                    elide: Text.ElideRight
                                }       

                                Text {
                                    width: parent.width
                                    text: player ? player.metadata["xesam:artist"].join(", ") : "Unknown Artist"
                                    color: Colors.secondary
                                    font.family: "Adwaita Sans"
                                    font.pixelSize: 14
                                    horizontalAlignment: Text.AlignHCenter
                                    elide: Text.ElideRight
                                }
                            }
                        }

                        RowLayout {
                            Layout.alignment: Qt.AlignHCenter
                            spacing: 20

                            Text {
                                text: player ? formatTime(player.position) : "0:00"
                                color: Colors.primary
                                font.pixelSize: 16
                                font.family: "Adwaita Sans"
                                Layout.preferredWidth: 45
                            }

                            Row {
                                Layout.alignment: Qt.AlignHCenter
                                spacing: 15

                                // prev button mate
                                Button {
                                    id: prev
                                    flat: true
                                    implicitHeight: 50
                                    implicitWidth: 50

                                    background: Rectangle {
                                        anchors.centerIn: parent
                                        color: parent.hovered ? Colors.primary : Colors.background
                                        radius: 10
                                        width: parent.hovered ? 60 : 50

                                        Behavior on width {
                                            NumberAnimation { duration: 250; easing.type: Easing.OutQuint }
                                        }
                                    }

                                    contentItem: Text {
                                        text: "󰒮"
                                        font.pixelSize: 24
                                        color: parent.hovered ? Colors.background : Colors.primary
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }

                                    onClicked: if(player) player.previous()
                                }

                                // omg play button
                                Button {
                                    id: play
                                    flat: true
                                    implicitHeight: 50
                                    implicitWidth: 50

                                    background: Rectangle {
                                        anchors.centerIn: parent
                                        color: parent.hovered ? Colors.secondary : Colors.background
                                        radius: 10
                                        width: parent.hovered ? 60 : 50

                                        Behavior on width {
                                            NumberAnimation { duration: 250; easing.type: Easing.OutQuint }
                                        }
                                    }

                                    contentItem: Text {
                                        text: player && player.playbackState == MprisPlaybackState.Playing ? "󰏤" : "󰐊"
                                        font.pixelSize: 24
                                        color: parent.hovered ? Colors.background : Colors.primary
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }

                                    onClicked: if(player) player.togglePlaying()
                                }

                                Button {
                                    id: next
                                    flat: true
                                    implicitHeight: 50
                                    implicitWidth: 50

                                    background: Rectangle {
                                        anchors.centerIn: parent
                                        color: parent.hovered ? Colors.primary : Colors.background
                                        radius: 10
                                        width: parent.hovered ? 60 : 50

                                        Behavior on width {
                                            NumberAnimation { duration: 250; easing.type: Easing.OutQuint }
                                        }
                                    }

                                    contentItem: Text {
                                        text:  "󰒭"
                                        font.pixelSize: 24
                                        color: parent.hovered ? Colors.background : Colors.primary
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }

                                    onClicked: if(player) player.next()
                                }
                            }

                            Text {
                                text: player ? formatTime(player.length) : "0:00"
                                color: Colors.primary
                                font.pixelSize: 16
                                font.family: "Adwaita Sans"
                                Layout.preferredWidth: 45
                            }
                        }
                    }
                }
                
                // TODO : System
                RowLayout {
                    Layout.margins: 10
                    spacing: 20

                    ColumnLayout {
                        
                    }
                }
            }

            // Pagination Dots
            Row {
                Layout.alignment: Qt.AlignHCenter
                spacing: 8
                Repeater {
                    model: 2
                    delegate: Rectangle {
                        width: popup.page === index ? 35 : 10
                        height: 10
                        color: popup.page === index ? Colors.primary : Colors.primary_container
                        Behavior on width { NumberAnimation { duration: 500; easing.type: Easing.OutQuint } }
                    }
                }
            }
        }
    }
}