//PushNotificationsView Class
//Matthew Neal

import Foundation
import SwiftUI

struct PushNotificationView: View {
    @State private var notificationsOn = false
    
    var body: some View {
        VStack {
            Toggle(isOn: $notificationsOn) {
                Text(notificationsOn ? "Notifications On" : "Notifications Off")
            }
            Text("Changes require manual adjustments in device settings.")
        }
    }
}

struct PushNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        PushNotificationView()
    }
}

