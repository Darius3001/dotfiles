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
    readonly property color foreground: "#e1e3eb"
    readonly property color muted: "#9399b2"
    readonly property color accent: "#eba6f7"
    readonly property color pink: "#f5c2e7"
    readonly property color otherDisplay: "#89b4fa"
    readonly property color warning: "#f38ba8"
    readonly property string fontFamily: "JetBrainsMono Nerd Font"
    property var powerMenuScreen: null

    readonly property var audio: Pipewire.defaultAudioSink?.audio ?? null
    readonly property var battery: UPower.displayDevice

    // Keep 1–5 available, and include any additional open workspaces.
    readonly property var workspaceIds: {
        const ids = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
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

            implicitHeight: 32
            color: "transparent"

            PowerMenu {
                screen: bar.modelData
                theme: root
                visible: root.powerMenuScreen === bar.modelData
                onDismissed: root.powerMenuScreen = null
            }

            Rectangle {
                anchors.fill: parent
                color: root.background

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 16
                    spacing: 16


                    Row {
                        spacing: 6
                        Layout.alignment: Qt.AlignVCenter

                        Repeater {
                            model: root.workspaceIds

                            Rectangle {
                                id: workspaceButton
                                required property int modelData
                                readonly property var workspace: Hyprland.workspaces.values.find(w => w.id === modelData) ?? null
                                readonly property bool active: bar.monitor?.activeWorkspace?.id === modelData
                                readonly property bool occupied: (workspace?.toplevels.values.length ?? 0) > 0
                                readonly property bool inUseElsewhere: (occupied || workspace?.active === true) && workspace?.monitor != null && bar.monitor != null && workspace.monitor.id !== bar.monitor.id

                                width: active ? 32 : 28
                                height: 28
                                radius: 9
                                color: active ? root.accent : workspaceMouse.containsMouse ? root.surface : "transparent"
                                gradient: active ? workspaceGradient : null
                                border.width: inUseElsewhere && !active ? 1 : 0
                                border.color: Qt.alpha(root.otherDisplay, 0.35)

                                Gradient {
                                    id: workspaceGradient
                                    orientation: Gradient.Horizontal
                                    GradientStop { position: 0; color: root.pink }
                                    GradientStop { position: 0.5; color: root.accent }
                                    GradientStop { position: 1; color: root.otherDisplay }
                                }

                                Behavior on width {
                                    NumberAnimation { duration: 180; easing.type: Easing.OutCubic }
                                }

                                Behavior on color {
                                    ColorAnimation { duration: 120 }
                                }

                                Label {
                                    anchors.centerIn: parent
                                    text: workspaceButton.modelData
                                    font.bold: workspaceButton.active
                                    color: workspaceButton.active ? root.background : workspaceButton.inUseElsewhere ? root.otherDisplay : workspaceButton.occupied ? root.foreground : root.muted
                                }

                                Rectangle {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 2
                                    width: 4
                                    height: 4
                                    radius: 2
                                    color: root.otherDisplay
                                    visible: workspaceButton.inUseElsewhere
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
                        implicitWidth: volumeLabel.implicitWidth + 24
                        implicitHeight: 28
                        radius: 9
                        color: volumeMouse.containsMouse ? root.surface : Qt.alpha(root.otherDisplay, 0.08)
                        border.width: 1
                        border.color: Qt.alpha(root.otherDisplay, volumeMouse.containsMouse ? 0.5 : 0.18)
                        visible: root.audio !== null

                        Behavior on color {
                            ColorAnimation { duration: 120 }
                        }

                        Label {
                            id: volumeLabel
                            anchors.centerIn: parent
                            text: root.audio?.muted ? "Muted" : "Vol " + Math.round((root.audio?.volume ?? 0) * 100) + "%"
                            color: root.audio?.muted ? root.muted : root.otherDisplay
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

                    Rectangle {
                        implicitWidth: timeLabel.implicitWidth + 24
                        implicitHeight: 28
                        Layout.alignment: Qt.AlignVCenter
                        radius: 9
                        gradient: Gradient {
                            orientation: Gradient.Horizontal
                            GradientStop { position: 0; color: root.pink }
                            GradientStop { position: 0.5; color: root.accent }
                            GradientStop { position: 1; color: root.otherDisplay }
                        }

                        Label {
                            id: timeLabel
                            anchors.centerIn: parent
                            text: Qt.formatDateTime(clock.date, "HH:mm")
                            font.bold: true
                            color: root.background
                        }
                    }

                    Rectangle {
                        implicitWidth: 32
                        implicitHeight: 28
                        Layout.alignment: Qt.AlignVCenter
                        radius: 9
                        color: powerMouse.containsMouse ? root.surface : "transparent"

                        Label {
                            anchors.centerIn: parent
                            text: "⏻"
                            font.pixelSize: 19
                            color: root.warning
                        }

                        MouseArea {
                            id: powerMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.powerMenuScreen = bar.modelData
                        }
                    }
                }
            }
        }
    }
}
