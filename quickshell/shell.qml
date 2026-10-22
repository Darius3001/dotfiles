import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

ShellRoot {
    id: root

    // Edit these to change the look of the whole bar.
    readonly property color background: "#1e1e2e"
    readonly property color surface: "#313244"
    readonly property color foreground: "#cdd6f4"
    readonly property color muted: "#9399b2"
    readonly property color accent: "#cba6f7"
    readonly property color warning: "#f38ba8"
    readonly property string fontFamily: "sans-serif"

    readonly property var audio: Pipewire.defaultAudioSink?.audio ?? null
    readonly property var battery: UPower.displayDevice

    // Keep 1–5 available, and include any additional open workspaces.
    readonly property var workspaceIds: {
        const ids = [1, 2, 3, 4, 5];
        for (const workspace of Hyprland.workspaces.values) {
            if (workspace.id > 0 && !ids.includes(workspace.id))
                ids.push(workspace.id);
        }
        return ids.sort((a, b) => a - b);
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    component Label: Text {
        color: root.foreground
        font.family: root.fontFamily
        font.pixelSize: 13
        textFormat: Text.PlainText
        verticalAlignment: Text.AlignVCenter
    }

    component Separator: Rectangle {
        implicitWidth: 1
        implicitHeight: 16
        color: root.surface
        Layout.alignment: Qt.AlignVCenter
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar
            required property var modelData
            readonly property var monitor: Hyprland.monitorFor(modelData)

            screen: modelData
            anchors {
                top: true
                left: true
                right: true
            }
            margins {
                top: 8
                left: 8
                right: 8
            }
            implicitHeight: 40
            color: "transparent"

            Rectangle {
                anchors.fill: parent
                color: root.background
                radius: 10
                border.color: root.surface
                border.width: 1

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 16
                    spacing: 16

                    Label {
                        text: "QS"
                        color: root.accent
                        font.bold: true
                        font.letterSpacing: 1
                    }

                    Row {
                        spacing: 4
                        Layout.alignment: Qt.AlignVCenter

                        Repeater {
                            model: root.workspaceIds

                            Rectangle {
                                id: workspaceButton
                                required property int modelData
                                readonly property bool active: bar.monitor?.activeWorkspace?.id === modelData
                                readonly property bool occupied: Hyprland.workspaces.values.some(w => w.id === modelData)

                                width: 28
                                height: 26
                                radius: 7
                                color: active ? root.accent : workspaceMouse.containsMouse ? root.surface : "transparent"

                                Behavior on color {
                                    ColorAnimation { duration: 120 }
                                }

                                Label {
                                    anchors.centerIn: parent
                                    text: workspaceButton.modelData
                                    font.bold: workspaceButton.active
                                    color: workspaceButton.active ? root.background : workspaceButton.occupied ? root.foreground : root.muted
                                }

                                MouseArea {
                                    id: workspaceMouse
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: Hyprland.dispatch("workspace " + workspaceButton.modelData)
                                }
                            }
                        }
                    }

                    Separator {}

                    Label {
                        Layout.fillWidth: true
                        Layout.minimumWidth: 0
                        text: Hyprland.activeToplevel?.title ?? "Desktop"
                        color: root.muted
                        elide: Text.ElideRight
                    }

                    Rectangle {
                        id: volumeControl
                        Layout.alignment: Qt.AlignVCenter
                        implicitWidth: volumeLabel.implicitWidth + 18
                        implicitHeight: 26
                        radius: 7
                        color: volumeMouse.containsMouse ? root.surface : "transparent"
                        visible: root.audio !== null

                        Label {
                            id: volumeLabel
                            anchors.centerIn: parent
                            text: root.audio?.muted ? "Muted" : "Vol " + Math.round((root.audio?.volume ?? 0) * 100) + "%"
                            color: root.audio?.muted ? root.muted : root.foreground
                        }

                        MouseArea {
                            id: volumeMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                if (root.audio)
                                    root.audio.muted = !root.audio.muted;
                            }
                            onWheel: event => {
                                if (root.audio && event.angleDelta.y !== 0) {
                                    const step = event.angleDelta.y > 0 ? 0.05 : -0.05;
                                    root.audio.volume = Math.max(0, Math.min(1, root.audio.volume + step));
                                }
                                event.accepted = true;
                            }
                        }
                    }

                    Label {
                        visible: root.battery?.isPresent ?? false
                        readonly property int percent: Math.round((root.battery?.percentage ?? 0) * 100)
                        text: (UPower.onBattery ? "Bat " : "AC ") + percent + "%"
                        color: UPower.onBattery && percent <= 20 ? root.warning : root.foreground
                    }

                    Separator {}

                    Label {
                        text: Qt.formatDateTime(clock.date, "ddd, MMM d")
                        color: root.muted
                    }

                    Label {
                        text: Qt.formatDateTime(clock.date, "HH:mm")
                        font.bold: true
                        color: root.accent
                    }
                }
            }
        }
    }
}
