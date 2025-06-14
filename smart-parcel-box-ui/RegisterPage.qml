import QtQuick
import QtQuick.Controls 2.15

Item {
    signal registrationSuccess()
    signal backClicked()
    
    Column {
        id: registerForm
        anchors.centerIn: parent
        spacing: 10
        width: 300
        
        Text {
            text: "用户注册"
            font.pointSize: 18
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }
        
        TextField {
            id: newUsernameField
            placeholderText: "用户名"
            width: parent.width
        }
        
        TextField {
            id: newPasswordField
            placeholderText: "密码"
            echoMode: TextField.Password
            width: parent.width
        }
        
        TextField {
            id: confirmPasswordField
            placeholderText: "确认密码"
            echoMode: TextField.Password
            width: parent.width
        }
        
        Button {
            text: "注册"
            width: parent.width
            onClicked: {
                if (newPasswordField.text !== confirmPasswordField.text) {
                    showMessage("两次输入的密码不一致")
                    return
                }
                
                if (userDb.createUser(newUsernameField.text, newPasswordField.text)) {
                    registrationSuccess()
                } else {
                    showMessage("注册失败，用户名可能已存在")
                }
            }
        }
        
        Button {
            text: "返回"
            width: parent.width
            onClicked: backClicked()
        }
    }
}
    