import Quickshell.Hyprland
import Quickshell.Services.UPower
import Quickshell.Io

import QtQuick
import QtQuick.Layouts

import "../assets/color"

Rectangle {
    signal toggleClicked() // We emit this to tell Main.qml to open the popup

    property int musicHeight: 0
    Process {
        id: cavaProc
        command: ["bash", "-c", "ava -p <(echo '[output]\nmethod = raw\nraw_target = /dev/stdout\ndata_format = ascii\nascii_max_range = 50\n[general]\nbars = 1')"]
        running: true
        stdout: SplitParser {
            onRead: (line) => {
                let val = parseInt(line.trim());
                if (!isNan(val)) {
                    musicHeight = val;
                }
            }
        }
    }
    
    anchors.fill: parent
    color: Colors.background

    ColumnLayout {
        anchors.fill: parent
        spacing: 8

        // Workspace Column
        Column {
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            spacing: 6
            Layout.topMargin: 5
            Repeater {
                model: 5
                delegate: Rectangle {
                    readonly property bool isFocus: Hyprland.focusedWorkspace && Hyprland.focusedWorkspace.id === (index + 1)
                    width: 10
                    height: isFocus ? 35 : 10
                    color: isFocus ? Colors.primary : Colors.primary_container
                    Behavior on height { NumberAnimation { duration: 500; easing.type: Easing.OutQuint } }
                    MouseArea { anchors.fill: parent; onClicked: Hyprland.dispatch(`workspace ${index + 1}`) }
                }
            }
        }

        // Center Button
        Rectangle {
            Layout.alignment: Qt.AlignCenter
            width: 25; height: 50
            color: "transparent"

            Rectangle { 
                color: Colors.primary
                radius: 0
                opacity: 0.5
                anchors.fill: parent


            }
            MouseArea { anchors.fill: parent; onClicked: toggleClicked() }
        }

        // Bottom Info (Battery + Clock)
        Column {
            Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
            Layout.bottomMargin: 5
            spacing: 5

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 15; height: 50; color: Colors.secondary_container
                Rectangle {
                    anchors.bottom: parent.bottom; width: parent.width
                    height: Math.max(1, parent.height * (UPower.displayDevice.percentage ?? 0))
                    color: Colors.secondary
                }
            }

            Column {
                Text { id: hour; text: Qt.formatDateTime(new Date(), "hh"); color: Colors.primary; font.pixelSize: 16; font.bold: true }
                Text { id: min; text: Qt.formatDateTime(new Date(), "mm"); color: Colors.primary; font.pixelSize: 16; font.bold: true }
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            hour.text = Qt.formatDateTime(new Date(), "hh")
            min.text = Qt.formatDateTime(new Date(), "mm")
        }
    }
}