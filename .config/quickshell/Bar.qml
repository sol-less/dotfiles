import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "./assets/color"
import "./modules"

Variants {
    model: Quickshell.screens
    
    PanelWindow {
        id: panel
        property var modelData: modelData
        screen: modelData
        color: "transparent"
        anchors { left: true; top: true; bottom: true }
        implicitWidth: 25

        // The Popup is now its own component
        SideBar {
            id: sidePopup
            anchorWindow: panel
        }

        // The Bar content is now its own component
        BarContent {
            onToggleClicked: sidePopup.toggle()
        }
    }
}