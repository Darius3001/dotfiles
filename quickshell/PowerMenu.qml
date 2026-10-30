import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: menu

    WlrLayershell.namespace: "quickshell-power-menu"

    required property var theme
    property int selectedIndex: 0
    property bool confirming: false
    readonly property var actions: [
        {
            label: "Suspend",
            icon: "󰒲",
            command: ["systemctl", "suspend"]
        },
        {
            label: "Log out",
            icon: "󰍃",
            command: ["hyprshutdown"]
        },
        {
            label: "Restart",
            icon: "󰜉",
            command: ["systemctl", "reboot"]
        },
        {
            label: "Shut down",
            icon: "⏻",
            command: ["systemctl", "poweroff"]
        }
    ]
    signal dismissed

    function selectNextEntry() {
        menu.selectedIndex = (menu.selectedIndex + 1) % menu.actions.length;
    }

    function selectPreviousEntry() {
        menu.selectedIndex = (menu.selectedIndex + menu.actions.length - 1) % menu.actions.length;
    }

    function activate() {
        if (menu.selectedIndex === 0 || confirming) {
            const command = actions[menu.selectedIndex].command;
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

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

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
            switch (true) {
                case [Qt.Key_Return, Qt.Key_Enter].includes(event.key):
                    menu.activate()
                    break
                case menu.confirming:
                    break
                case [Qt.Key_Down, Qt.Key_J, Qt.Key_Tab].includes(event.key):
                case (event.modifiers & Qt.ControlModifier) && event.key == Qt.Key_N:
                    menu.selectNextEntry()
                    break
                case [Qt.Key_Up, Qt.Key_Backtab, Qt.Key_K].includes(event.key):
                case (event.modifiers & Qt.ControlModifier) && event.key == Qt.Key_P:
                    menu.selectPreviousEntry()
                    break
                default:
                    return
            }
            event.accepted = true;
        }

        Rectangle {
            anchors.centerIn: parent
            width: Math.min(360, parent.width - 32)
            height: content.implicitHeight + 40
            radius: 18
            color: Qt.alpha(menu.theme.background, 0.45)


            // Keep clicks inside the card from dismissing the menu.
            MouseArea {
                anchors.fill: parent
            }

            ColumnLayout {
                id: content
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    margins: 20
                }
                spacing: 10

                Text {
                    text: menu.confirming ? menu.actions[menu.selectedIndex].label + "?" : "Power menu"
                    color: menu.theme.foreground
                    font {
                        family: menu.theme.fontFamily
                        pixelSize: 20
                        bold: true
                    }
                }

                Repeater {
                    model: menu.confirming ? 0 : menu.actions.length

                    Rectangle {
                        id: actionButton
                        required property int index
                        Layout.fillWidth: true
                        implicitHeight: 46
                        radius: 10
                        color: menu.selectedIndex === index ? Qt.alpha(menu.theme.surface, 0.7) : "transparent"

                        Text {
                            anchors {
                                left: parent.left
                                leftMargin: 14
                                verticalCenter: parent.verticalCenter
                            }
                            text: menu.actions[actionButton.index].icon + "   " + menu.actions[actionButton.index].label
                            color: actionButton.index === 3 ? menu.theme.warning : menu.theme.foreground
                            font {
                                family: menu.theme.fontFamily
                                pixelSize: 14
                            }
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
                        font {
                            family: menu.theme.fontFamily
                            pixelSize: 14
                            bold: true
                        }
                    }

                    MouseArea {
                        id: confirmMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: menu.activate(menu.selectedIndex)
                    }
                }
            }
        }
    }
}
