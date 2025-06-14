import QtQuick
import QtQuick.VirtualKeyboard
import QtQuick.Controls 2.15

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

    //导航函数
    function goToLogin(){currentPage = "login"}
    function goToRegister(){currentPage = "register"}
    function goToDelivery(){currentPage = "delivery"}
    function goToPickup(){currentPage = "pickup"}

    //顶部导航栏
    Row{

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
}
