import QtQuick

pragma Singleton

QtObject {
    // Main Pallete
  
    readonly property color background: "#0f1416"
    readonly property color foreground: "#dee3e6"
    readonly property color accent: "#88d1eb"

    // The Big Three
    
    readonly property color primary: "#88d1eb"
    readonly property color primary_container: "#004e60"

    readonly property color secondary: "#b3cad4"
    readonly property color secondary_container: "#344a52"

    readonly property color tertiary: "#c3c3eb"
    readonly property color tertiary_container: "#424465"

    readonly property color surface_variant: "#40484c"
}
