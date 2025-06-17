import QtQuick
import QtQuick.Controls

Item {
    id:loginView
    Image{
        id:delivery_image
        width: parent.width
        fillMode: Image.PreserveAspectFit
        //Component.onCompleted: {delivery_image.source="qrc:/new/prefix1/delivery.png"}
        source: "qrc:/new/prefix1/delivery.png"
        onStatusChanged: {
            if(status === Image.Ready){console.log("图片加载成功")}
            else if(status === Image.Error){console.log("图片加载失败:", errorString)}
        }
    }

    Column{
        spacing:10
        anchors.centerIn: parent
        width: parent.width*0.8
        TextField{
            id:phoneNumberField
            placeholderText: "输入手机号码"   //框内提示
            validator: RegularExpressionValidator{regularExpression: /^[0-9]{11}$/} //正则表达，0-9的输入，最多11位
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter   //水平居中对齐
            inputMethodHints: Qt.ImhDialableCharactersOnly //数字键盘
            font.pixelSize: 25
        }
        TextField{
            id:passwordField
            width:parent.width
            placeholderText: "输入密码" //框内提示
            anchors.horizontalCenter: parent.horizontalCenter
            echoMode: TextInput.Password
            //inputMethodHints:Qt.ImhNoPredictiveText|Qt.ImhLatinOnly|Qt.ImhSensitiveData
            inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhPreferLatin | Qt.ImhSensitiveData
            font.pixelSize: 25
        }
        Row{
            spacing: 10
            Button{
                text: "登 录"
                font.pixelSize: 25
                onClicked: {
                    //手机或密码不能为空
                    if(phoneNumberField.text===""||passwordField.text===""){
                        receivedMessage.text = "手机或密码不能为空"
                    }else if(phoneNumberField.text.length!==11){
                        receivedMessage.text = "手机号格式不对"
                    }else{}
                }
            }
            Button{
                text:"取 消"
                font.pixelSize: 25
                enabled: stack.depth>1
                onClicked: stack.pop()
            }
        }

        // 显示接收到的消息
        Text {
            id: receivedMessage
            text: "Received message: " // 初始化文本
        }
    }
}
