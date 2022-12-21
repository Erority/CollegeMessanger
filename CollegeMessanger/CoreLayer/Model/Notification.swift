//
//  Notification.swift
//  CollegeMessanger
//
//  Created by Студент on 21.12.2022.
//

import Foundation
import FirebaseFirestore

struct NotificationModel{
    var notificationGroup: String
    var notificationText: String
    var notificationTime: Timestamp
    var notificationTimeStart: Timestamp
    var notificationTitle: String
}
