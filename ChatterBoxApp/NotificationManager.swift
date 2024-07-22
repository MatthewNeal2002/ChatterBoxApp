//NotificationManager class
//Matthew Neal

import Foundation
import FirebaseFirestore
import FirebaseSharedSwift

class NotificationManager: ObservableObject {
    @Published private(set) var notification_email_list: [notification_email_list] = []
    @Published private(set) var lastNotificationID = ""
    let db = Firestore.firestore()
    
    func setNotification(notify: Bool, email: String) {
        do {
            let setNotification = ChatterBoxApp.notification_email_list(id: "\(UUID())", email: email, notify: notify, timestamp: Date())
            try db.collection("notification_email_list").document().setData(from: setNotification)
        } catch {
            print("Error adding message to Firestore: \(error)")
        }
    }
}

