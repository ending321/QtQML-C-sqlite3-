import QtQuick
import QtQuick.Controls 2.15

Item {
    signal pickupSuccess(string trackingNumber)
    signal backClicked()
    
    Column {
        id: pickupForm
        anchors.centerIn: parent
        spacing: 10
        width: 300
        
        Text {
            text: "包裹取件"
            font.pointSize: 18
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }
        
        TextField {
            id: pickupTrackingNumberField
            placeholderText: "包裹单号"
            width: parent.width
        }
        
        TextField {
            id: pickupCodeField
            placeholderText: "取件码"
            width: parent.width
        }
        
        Button {
            text: "确认取件"
            width: parent.width
            onClicked: {
                if (userDb.retrievePackage(pickupTrackingNumberField.text, pickupCodeField.text)) {
                    pickupSuccess(pickupTrackingNumberField.text)
                    
                    // 清空表单
                    pickupTrackingNumberField.text = ""
                    pickupCodeField.text = ""
                } else {
                    showMessage("取件失败，单号或取件码错误")
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
    