import QtQuick
import QtQuick.Controls 2.15

Item {
    signal loginSuccess(string username)
    signal registerClicked()
    
    Column {
        id: loginForm
        anchors.centerIn: parent
        spacing: 10
        width: 300
        
        Text {
            text: "用户登录"
            font.pointSize: 18
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }
        
        TextField {
            id: usernameField
            placeholderText: "用户名"
            width: parent.width
        }
        
        TextField {
            id: passwordField
            placeholderText: "密码"
            echoMode: TextField.Password
            width: parent.width
        }
        
        Button {
            text: "登录"
            width: parent.width
            onClicked: {
                if (userDb.validateUser(usernameField.text, passwordField.text)) {
                    loginSuccess(usernameField.text)
                } else {
                    showMessage("用户名或密码错误")
                }
            }
        }
        
        Button {
            text: "注册新用户"
            width: parent.width
            onClicked: registerClicked()
        }
    }
}
    