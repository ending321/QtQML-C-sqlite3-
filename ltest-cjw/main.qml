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
