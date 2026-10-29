import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: menu

    required property var theme
    property int selectedIndex: 0
    property bool confirming: false
    readonly property var actions: [
        { label: "Suspend", icon: "󰒲", command: ["systemctl", "suspend"] },
        { label: "Log out", icon: "󰍃", command: ["hyprshutdown"] },
        { label: "Restart", icon: "󰜉", command: ["systemctl", "reboot"] },
        { label: "Shut down", icon: "⏻", command: ["systemctl", "poweroff"] }
    ]
    signal dismissed()

    function activate(index) {
        selectedIndex = index;
        if (index === 0 || confirming) {
            const command = actions[index].command;
            dismissed();
            Quickshell.execDetached(command);
        } else {
            confirming = true;
        }
    }

    function cancel() {
        if (confirming)
            confirming = false;
        else
            dismissed();
    }

    onVisibleChanged: {
        selectedIndex = 0;
        confirming = false;
        if (visible)
            keyboard.forceActiveFocus();
    }

    anchors { top: true; bottom: true; left: true; right: true }
    exclusionMode: ExclusionMode.Ignore
    color: "transparent"
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: visible ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

    Rectangle {
        anchors.fill: parent
        color: "#99000000"

        MouseArea {
            anchors.fill: parent
            onClicked: menu.dismissed()
        }
    }

    FocusScope {
        id: keyboard
        anchors.fill: parent
        focus: true

        Keys.onEscapePressed: menu.cancel()
        Keys.onPressed: event => {
            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                menu.activate(menu.selectedIndex);
            } else if (!menu.confirming && (event.key === Qt.Key_Down || event.key === Qt.Key_Tab)) {
                menu.selectedIndex = (menu.selectedIndex + (event.modifiers & Qt.ShiftModifier ? 3 : 1)) % menu.actions.length;
            } else if (!menu.confirming && event.key === Qt.Key_Up) {
                menu.selectedIndex = (menu.selectedIndex + menu.actions.length - 1) % menu.actions.length;
            } else {
                return;
            }
            event.accepted = true;
        }

        Rectangle {
            anchors.centerIn: parent
            width: Math.min(360, parent.width - 32)
            height: content.implicitHeight + 40
            radius: 18
            color: menu.theme.background
            border.width: 2
            border.color: menu.theme.accent

            // Keep clicks inside the card from dismissing the menu.
            MouseArea { anchors.fill: parent }

            ColumnLayout {
                id: content
                anchors { left: parent.left; right: parent.right; top: parent.top; margins: 20 }
                spacing: 10

                Text {
                    text: menu.confirming ? menu.actions[menu.selectedIndex].label + "?" : "Power menu"
                    color: menu.theme.foreground
                    font { family: menu.theme.fontFamily; pixelSize: 20; bold: true }
                }

                Text {
                    Layout.fillWidth: true
                    text: menu.confirming ? "Confirm to continue." : "↑ / ↓ to select · Enter to continue"
                    color: menu.theme.muted
                    font { family: menu.theme.fontFamily; pixelSize: 11 }
                    wrapMode: Text.WordWrap
                }

                Repeater {
                    model: menu.confirming ? 0 : menu.actions.length

                    Rectangle {
                        id: actionButton
                        required property int index
                        Layout.fillWidth: true
                        implicitHeight: 46
                        radius: 10
                        color: menu.selectedIndex === index ? menu.theme.surface : "transparent"

                        Text {
                            anchors { left: parent.left; leftMargin: 14; verticalCenter: parent.verticalCenter }
                            text: menu.actions[actionButton.index].icon + "   " + menu.actions[actionButton.index].label
                            color: actionButton.index === 3 ? menu.theme.warning : menu.theme.foreground
                            font { family: menu.theme.fontFamily; pixelSize: 14 }
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onEntered: menu.selectedIndex = actionButton.index
                            onClicked: menu.activate(actionButton.index)
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: 46
                    radius: 10
                    color: confirmMouse.containsMouse ? menu.theme.warning : menu.theme.accent
                    visible: menu.confirming

                    Text {
                        anchors.centerIn: parent
                        text: "Confirm " + menu.actions[menu.selectedIndex].label.toLowerCase()
                        color: menu.theme.background
                        font { family: menu.theme.fontFamily; pixelSize: 14; bold: true }
                    }

                    MouseArea {
                        id: confirmMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: menu.activate(menu.selectedIndex)
                    }
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: menu.confirming ? "Cancel · Esc" : "Close · Esc"
                    color: cancelMouse.containsMouse ? menu.theme.foreground : menu.theme.muted
                    font { family: menu.theme.fontFamily; pixelSize: 12 }

                    MouseArea {
                        id: cancelMouse
                        anchors.fill: parent
                        anchors.margins: -6
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: menu.cancel()
                    }
                }
            }
        }
    }
}
