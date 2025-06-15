import QtQuick
import QtQuick.Controls 2.15
import com.example.UserDatabase 1.0

Item {
    id: loginPage
    signal loginSuccess(string username)
    signal registerClicked()

    // 注入数据库对象（需在 main.qml 中注册 userDb）
    property UserDatabase userDb: null
    property var stack: null             // 接收 stack 实例

    Column{
        id:loginForm
        anchors.centerIn: parent
        spacing: 10
        width: 300

        Text{
            text:"用户登录"
            font.pointSize: 18
            horizontalAlignment: Text.AlignHCenter
            width:parent.width
        }

        TextField{
            id:usernameField
            placeholderText:"用户名"
            width:parent.width
        }

        TextField{
            id:passwordField
            placeholderText: "密码"
            echoMode: TextField.Password
            width:parent.width
        }
        Button{
            text:"登录"
            width:parent.width
            onClicked:{
                if(userDb.validateUser(usernameField.text, passwordField.text)){
                    loginSuccess(usernameField.text)
                    //showMessage("登录成功, 欢迎" + usernameField.text)
                    stack.push("qrc:/RegisterPage.qml") //test测试
                }else{
                    Qt.warning("用户名或密码错误")  //test测试
                    //showMessage("用户名或密码错误")
                }
            }
        }

        Button{
            text:"注册新用户"
            width:parent.width
            onClicked: stack.push("qrc:/RegisterPage.qml")
        }
    }

    // 显示消息提示
    function showMessage(text) {
        messageDialog.text = text
        messageDialog.open()    //open是用来显示一个对话框的方法
    }
}
