import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

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

    Connections {
        target: sddm

        function onLoginFailed() {
            root.authenticating = false;
            error.text = "Login failed. Please try again.";
            password.clear();
            password.forceActiveFocus();
        }
    }

    ComboBox {
        id: session
        Layout.fillWidth: true
        model: sessionModel
        textRole: "name"
        currentIndex: sessionModel.lastIndex

        anchors {
            top: parent.top
            left: parent.left
        }
    }

    RowLayout {
        Layout.alignment: Qt.AlignHCenter
        Layout.topMargin: 12
        spacing: 8
        anchors {
            top: parent.top
            right: parent.right
        }

        Button {
            text: "Suspend"
            visible: sddm.canSuspend
            onClicked: sddm.suspend()
        }

        Button {
            text: "Restart"
            visible: sddm.canReboot
            onClicked: sddm.reboot()
        }

        Button {
            text: "Shut down"
            visible: sddm.canPowerOff
            onClicked: sddm.powerOff()
        }
    }
    ColumnLayout {
        anchors.centerIn: parent
        width: Math.min(320, parent.width - 48)
        spacing: 12
        enabled: !root.authenticating

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
            Layout.fillWidth: true
            text: root.authenticating ? "Signing in…" : "Sign in"
            enabled: username.text.trim().length > 0 && session.currentIndex >= 0
            onClicked: root.login()
        }
    }
}
