//notification_email_list class
//Matthew Neal

import Foundation

struct notification_email_list: Identifiable, Codable 
{
    var id: String
    var email: String
    var notify: Bool
    var timestamp: Date
}

