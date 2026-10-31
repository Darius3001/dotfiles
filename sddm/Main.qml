import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
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

    RectangularGlow {
        anchors.centerIn: input_column
        height: input_column.height + 64
        width: input_column.width + 32
        glowRadius: 1
        spread: 0.7
        color: "#99000000"
        cornerRadius: 8
    }

    ColumnLayout {
        id: input_column
        anchors.centerIn: parent
        width: Math.min(320, parent.width - 48)
        spacing: 12
        enabled: !root.authenticating

        Item { height: 8 }

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
