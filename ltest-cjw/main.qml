import QtQuick
import QtQuick.VirtualKeyboard
import QtQuick.Controls

Window {
    id: window
    width: 480
    height: 854
    visible: true
    //title: qsTr("Hello World")
    //property int text_size: 25
    //property int spacing_size: 10
    property string host:"192.168.31.148"   //本机IP
    property int port:8888

    StackView{
        id:stack
        initialItem: mainView   // 初始显示的页面
        anchors.fill: parent    // 填充父容器
    }

    Component{
        id:mainView

        Column{
            spacing: 10

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

            Button{
                id:deliveryButton
                anchors.horizontalCenter: parent.horizontalCenter   // 水平居中于父容器
                width: parent.width*0.5 // 宽度为父容器的一半

                //自定义背景样式
                background:Rectangle{
                    radius:8
                    color:deliveryButton.pressed?"darkblue":"#FFF0F0"
                    border.color: "#FFCCCC"
                    border.width: 1

                }
                contentItem: Text { //按钮文本内容
                    id: button_delivery
                    text: qsTr("投 递")
                    font.pixelSize: 25
                    horizontalAlignment: Text.AlignHCenter  // 文本水平居中
                }
                //onClicked: stack.push(("qrc:/login.qml"))
            }

        }
    }

    InputPanel {
        id: inputPanel
        z: 99
        x: 0
        y: window.height
        width: window.width

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: window.height - inputPanel.height
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
