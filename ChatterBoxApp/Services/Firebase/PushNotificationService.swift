//PushNotificationService class
//Matthew Neal


import Foundation
import FirebaseFirestore
import FirebaseSharedSwift

public class NotificationService {
    
    @Published private(set) var notificationsArray: [notifications] = []
    @Published private(set) var lastNotificationID = ""
    let db = Firestore.firestore()

    init() {
        sendNotifications()
    }
    
    func sendNotifications() {
        db.collection("notifications").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            
            self.notificationsArray = documents.compactMap { document -> notifications? in
                do {
                    return try document.data(as: notifications.self)
                } catch {
                    print("Error decoding document into Message: \(error)")
                    return nil
                }
            }
                        
            if let id = self.notificationsArray.last?.id {
                self.lastNotificationID = id
             }
         }
    }
}
