import QtQuick
import QtQuick.VirtualKeyboard
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: mainwindow
    width: 640
    height: 480
    visible: true
    title: qsTr("智能快递柜系统")

    property string currentPage:"login"
    //存储当前登录用户
    property string currentUser: ""

    //存储消息提示
    function showMessage(text){
        messageDialog.text = text
        messageDialog.open()
    }

    Column {
            anchors.fill: parent
            spacing: 8

            // 保留原有导航栏
            Row {
                id: navBar
                width: parent.width
                height: 40
                spacing: 20
                // 导航按钮逻辑（与StackView结合）
                Button {
                    text: "登录"
                    onClicked: stack.push("qrc:/LoginPage.qml")
                }
                Button {
                    text: "注册"
                    onClicked: stack.push("qrc:/RegisterPage.qml")
                }
            }
    }

    StackView{
        id:stack
        anchors.fill: parent
        initialItem: "qrc:/LoginPage.qml"
    }
    /*
    Button{
        text: "发送UDP消息"
        anchors.centerIn: parent
        onClicked: {
            //调用C++对象的方法
            udpclient.sendMessage("Hello from QML!")
        }
    }
    */
    //消息对话框
    Dialog{
        id:messageDialog
        title:"提示"
        contentItem: Text{
            text:""
            anchors.fill: parent
            padding:10
        }
        standardButtons: Dialog.Ok
    }
}
