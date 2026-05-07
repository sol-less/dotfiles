import QtQuick

pragma Singleton

QtObject {
    // Main Pallete
  
    readonly property color background: "{{colors.background.default.hex}}"
    readonly property color foreground: "{{colors.on_surface.default.hex}}"
    readonly property color accent: "{{colors.primary.default.hex}}"

    // The Big Three
    
    readonly property color primary: "{{colors.primary.default.hex}}"
    readonly property color primary_container: "{{colors.primary_container.default.hex}}"

    readonly property color secondary: "{{colors.secondary.default.hex}}"
    readonly property color secondary_container: "{{colors.secondary_container.default.hex}}"

    readonly property color tertiary: "{{colors.tertiary.default.hex}}"
    readonly property color tertiary_container: "{{colors.tertiary_container.default.hex}}"

    readonly property color surface_variant: "{{colors.surface_variant.default.hex}}"
}
