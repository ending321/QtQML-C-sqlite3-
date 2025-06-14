import QtQuick
import QtQuick.Controls 2.15

Item {
    property string currentUser
    
    signal deliverySuccess(string trackingNumber, string pickupCode)
    signal backClicked()
    
    Column {
        id: deliveryForm
        anchors.centerIn: parent
        spacing: 10
        width: 300
        
        Text {
            text: "包裹投递"
            font.pointSize: 18
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }
        
        Text {
            text: "投递员: " + currentUser
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }
        
        TextField {
            id: trackingNumberField
            placeholderText: "包裹单号"
            width: parent.width
        }
        
        TextField {
            id: recipientField
            placeholderText: "收件人"
            width: parent.width
        }
        
        TextField {
            id: lockerIdField
            placeholderText: "柜号"
            width: parent.width
        }
        
        Button {
            text: "确认投递"
            width: parent.width
            onClicked: {
                if (userDb.createPackage(trackingNumberField.text, recipientField.text, lockerIdField.text)) {
                    var code = userDb.getPackageCode(trackingNumberField.text)
                    deliverySuccess(trackingNumberField.text, code)
                    
                    // 清空表单
                    trackingNumberField.text = ""
                    recipientField.text = ""
                    lockerIdField.text = ""
                } else {
                    showMessage("投递失败，单号可能已存在")
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
    