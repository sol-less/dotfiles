import Quickshell

import QtQuick

ShellRoot {
    id: root

    Loader {
        active: true
        sourceComponent: Bar {}
    }
}