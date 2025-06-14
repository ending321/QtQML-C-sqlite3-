import QtQuick
import QtQuick.VirtualKeyboard
import QtQuick.Controls 2.15

ApplicationWindow {
    id: mainWindow
    width: 800
    height: 600
    visible: true
    title: qsTr("智能快递柜系统")
    
    property string currentPage: "login"
    
    // 存储当前登录用户
    property string currentUser: ""
    
    // 显示消息提示
    function showMessage(text) {
        messageDialog.text = text
        messageDialog.open()    //open是用来显示一个对话框的方法
    }
    
    // 导航函数
    function goToLogin() { currentPage = "login" }
    function goToRegister() { currentPage = "register" }
    function goToDelivery() { currentPage = "delivery" }
    function goToPickup() { currentPage = "pickup" }
    
    Column {
        id: mainColumn
        anchors.fill: parent
        
        // 顶部导航栏
        Row {
            id: navBar
            width: parent.width
            height: 40
            background: Rectangle { color: "#4a6fa5" }
            
            Button {
                text: "登录"
                enabled: currentPage !== "login"
                onClicked: goToLogin()
            }
            
            Button {
                text: "注册"
                enabled: currentPage !== "register"
                onClicked: goToRegister()
            }
            
            Button {
                text: "投递"
                enabled: currentPage !== "delivery" && currentUser !== ""
                onClicked: goToDelivery()
            }
            
            Button {
                text: "取件"
                enabled: currentPage !== "pickup"
                onClicked: goToPickup()
            }
        }
        
        // 主内容区域
        Item {
            id: contentArea
            width: parent.width
            height: parent.height - navBar.height
            
            // 登录页面
            LoginPage {
                id: loginPage
                anchors.fill: parent
                visible: currentPage === "login"
                onLoginSuccess: {
                    currentUser = username
                    showMessage("登录成功，欢迎 " + username)
                    goToDelivery()
                }
                onRegisterClicked: goToRegister()
            }
            
            // 注册页面
            RegisterPage {
                id: registerPage
                anchors.fill: parent
                visible: currentPage === "register"
                onRegistrationSuccess: {
                    showMessage("注册成功，请登录")
                    goToLogin()
                }
                onBackClicked: goToLogin()
            }
            
            // 投递页面
            DeliveryPage {
                id: deliveryPage
                anchors.fill: parent
                visible: currentPage === "delivery"
                currentUser: currentUser
                onDeliverySuccess: {
                    showMessage("包裹已成功投递，取件码: " + pickupCode)
                    // 发送UDP消息通知服务器
                    udpclient.sendMessage("PACKAGE_DELIVERED:" + trackingNumber + "," + recipient)
                }
                onBackClicked: goToLogin()
            }
            
            // 取件页面
            PickupPage {
                id: pickupPage
                anchors.fill: parent
                visible: currentPage === "pickup"
                onPickupSuccess: {
                    showMessage("包裹已成功取出")
                    // 发送UDP消息通知服务器
                    udpclient.sendMessage("PACKAGE_RETRIEVED:" + trackingNumber)
                }
                onBackClicked: goToLogin()
            }
        }
    }
    
    // 消息对话框
    Dialog {
        id: messageDialog
        title: "消息"
        modal: true
        contentItem: Text {
            id: messageText
            text: ""
            wrapMode: Text.Wrap    //当文本长度超出对话框宽度时，文本会自动换行
            anchors.margins: 10    //让文本与对话框边缘保持 10 像素的间距，使显示效果更加美观
        }
        buttons: Button {
            text: "确定"
            onClicked: messageDialog.close()
        }
    }
    
    // 监听UDP消息
    Connections {
        target: udpclient
        onMessageReceived: {
            showMessage("收到消息: " + msg)
        }
    }
    
    // 虚拟键盘
    InputPanel {
        id: inputPanel
        z: 99
        x: 0
        y: mainWindow.height
        width: mainWindow.width

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: mainWindow.height - inputPanel.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
}
    
