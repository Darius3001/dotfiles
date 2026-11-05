import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Effects
import Qt5Compat.GraphicalEffects

Rectangle {
    id: root

    width: 1280
    height: 720
    color: "#151515"

    property bool authenticating: false

    function login() {
        if (authenticating || !username.text.trim() || session.currentIndex < 0)
            return;

        error.text = "";
        authenticating = true;
        sddm.login(username.text.trim(), password.text, session.currentIndex);
    }

    Image {
        id: backgroundImage
        anchors.fill: parent
        source: "a_street_with_buildings_and_signs.png"
    }

    Connections {
        target: sddm

        function onLoginFailed() {
            root.authenticating = false;
            error.text = "Login failed. Please try again.";
            password.clear();
            password.forceActiveFocus();
        }
    }

    RowLayout {
        Layout.alignment: Qt.AlignHCenter
        spacing: 8
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            leftMargin: 10
            topMargin: 10
            rightMargin: 10
        }

        ComboBox {
            id: session
            model: sessionModel
            textRole: "name"
            currentIndex: sessionModel.lastIndex
        }

        Item {
            Layout.fillWidth: true
        }

        Button {
            text: "Suspend"
            visible: true
            onClicked: sddm.suspend()
        }

        Button {
            text: "Restart"
            visible: true
            onClicked: sddm.reboot()
        }

        Button {
            text: "Shut down"
            visible: true
            onClicked: sddm.powerOff()
        }
    }

    ShaderEffectSource {
        id: effectSource
        anchors.fill: input_box
        sourceItem: backgroundImage
        sourceRect: Qt.rect(input_box.x, input_box.y, input_box.width, input_box.height)
        visible: false
        
    }

    FastBlur {
        id: blurredBackground
        anchors.fill: effectSource
        source: effectSource
        radius: 50
        visible: false
    }

    Rectangle {
        id: roundedMask
        anchors.fill: effectSource
        radius: input_box.cornerRadius
        color: "white"
        visible: false
    }

    OpacityMask {
        anchors.fill: effectSource
        source: blurredBackground
        maskSource: roundedMask
    }

    RectangularGlow {
        id: input_box
        anchors.centerIn: input_column
        height: input_column.height + 64
        width: input_column.width + 32
        glowRadius: 1
        spread: 0.7
        color: "#aa282A36"
        cornerRadius: 16
    }

    ColumnLayout {
        id: input_column
        anchors.centerIn: parent
        width: Math.min(320, parent.width - 48)
        spacing: 12
        enabled: !root.authenticating

        Item {
            height: 8
        }

        Label {
            text: "Sign in"
            color: "#eeeeee"
            font.pixelSize: 24
            Layout.bottomMargin: 12
        }

        Label {
            text: "User"
            color: "#bbbbbb"
        }

        TextField {
            id: username
            Layout.fillWidth: true
            text: userModel.lastUser
            placeholderText: "Username"
            selectByMouse: true
            activeFocusOnTab: true
            onAccepted: password.forceActiveFocus()
            Component.onCompleted: {
                if (text.length > 0)
                    password.forceActiveFocus();
                else
                    forceActiveFocus();
            }
            color: "#e1e3eb"
            placeholderTextColor: "#9399b2"
            background: Rectangle {
                color: "#aa212234"
                border.color: "#212234"
                radius: 16
            }
            leftInset: -6
            rightInset: -6
            topInset: -2
            bottomInset: -2
        }

        Label {
            text: "Password"
            color: "#bbbbbb"
        }

        TextField {
            id: password
            Layout.fillWidth: true
            placeholderText: "Password"
            echoMode: TextInput.Password
            selectByMouse: true
            activeFocusOnTab: true
            onAccepted: root.login()
            color: "#e1e3eb"
            placeholderTextColor: "#9399b2"
            background: Rectangle {
                color: "#aa212234"
                border.color: "#212234"
                radius: 16
            }
            leftInset: -6
            rightInset: -6
            topInset: -2
            bottomInset: -2
        }

        Label {
            text: "Session"
            color: "#bbbbbb"
        }

        Label {
            id: error
            Layout.fillWidth: true
            visible: text.length > 0
            color: "#ff9999"
            wrapMode: Text.WordWrap
        }

        Button {
            id: login_button
            Layout.fillWidth: true
            // passwordless users dont work lol
            enabled: username.text.trim().length > 0 && session.currentIndex >= 0 && password.text.length > 0
            onClicked: root.login()
            contentItem: Label {
                text: root.authenticating ? "Signing in…" : "Sign in"
                color: login_button.enabled ? "#212234" : "#9399b2"
            }
            background: Rectangle {
                color: login_button.enabled ? "#e1e3eb" : "#aa212234"
                border.color: login_button.enabled ? "#e1e3eb" : "#aa212234"
                radius: 16
            }
            leftInset: -6
            rightInset: -6
            topInset: -2
            bottomInset: -2
        }
    }
}
