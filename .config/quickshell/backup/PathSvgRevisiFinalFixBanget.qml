import Quickshell
import QtQuick
import QtQuick.Shapes

PanelWindow {
    id: root
    width: 500
    // Try changing this height! The rectangle and curves will stretch/adapt.
    height: 420
    color: "black"

    // Define properties to easily control the layout mathematically
    property int verticalPadding: 25
    property int curveRadius: 25

    Item {
        id: container
        anchors.fill: parent // Dynamically fill the window

        // The "Real" Rectangle centered vertically
        Rectangle {
            id: middleRect
            x: 0
            y: root.verticalPadding
            width: 450
            // Stretches based on container height minus top and bottom padding
            height: container.height - (root.verticalPadding * 2)
            radius: 20
            color: "white"
        }

        Shape {
            anchors.fill: parent
            layer.enabled: true
            layer.samples: 8

            ShapePath {
                fillColor: "white"
                strokeColor: "transparent"

                // --- TOP BAR ---
                // Dynamically tied to the top edge of middleRect
                PathMove { x: 0; y: middleRect.y - root.curveRadius }
                PathLine { x: 0; y: middleRect.y + root.curveRadius } // Overlaps rect slightly to hide seam
                PathLine { x: root.curveRadius; y: middleRect.y + root.curveRadius }
                PathLine { x: root.curveRadius; y: middleRect.y }
                PathArc {
                    x: 0; y: middleRect.y - root.curveRadius
                    radiusX: root.curveRadius; radiusY: root.curveRadius
                    useLargeArc: false
                    direction: PathArc.Clockwise
                }

                // --- BOTTOM BAR ---
                // Dynamically tied to the bottom edge of middleRect (y + height)
                PathMove { x: 0; y: middleRect.y + middleRect.height + root.curveRadius }
                PathLine { x: 0; y: middleRect.y + middleRect.height - root.curveRadius }
                PathLine { x: root.curveRadius; y: middleRect.y + middleRect.height - root.curveRadius }
                PathLine { x: root.curveRadius; y: middleRect.y + middleRect.height }
                PathArc {
                    x: 0; y: middleRect.y + middleRect.height + root.curveRadius
                    // Note: In your original code, this was 30. I've set it to curveRadius (25) 
                    // for symmetry, but you can change it back to 30 if intended!
                    radiusX: root.curveRadius; radiusY: root.curveRadius 
                    useLargeArc: false
                    direction: PathArc.Counterclockwise
                }
            }
        }
    }
}