//
//  NotificationService.swift
//  CollegeMessanger
//
//  Created by Студент on 21.12.2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore


protocol NotificationsService {
    func getNotifications(_ clouser: @escaping (_ allNotifications: [NotificationModel]?, _ error: Error?) -> ())
    func addNotificationst(notification: NotificationModel, _ clouser: @escaping (_ success: Bool, _ error: Error?) -> ())
}


class NotificationsServiceImpl: NotificationsService {
    
    private let collection = Firestore.firestore().collection(FirebaseCollection.notifications.rawValue)
    
    func getNotifications(_ clouser: @escaping (_ allNotifications: [NotificationModel]?, _ error: Error?) -> ()) {
        collection.getDocuments { snapshot, error in

            if let error = error {
                print("Error getting documents: \(error)")
                clouser(nil, error)
            } else {
                var allNotification: [NotificationModel] = []

                for document in snapshot!.documents {
                    allNotification.append(NotificationModel(
                        notificationGroup: document.data()["notificationGroup"] as? String ?? "",
                        notificationText: document.data()["notificationText"] as? String ?? "",
                        notificationTime: document.data()["notificationTime"] as? Timestamp ?? Timestamp(),
                        notificationTimeStart: document.data()["notificationTimeStart"] as? Timestamp ?? Timestamp(),
                        notificationTitle: document.data()["notificationTitle"] as? String ?? "")
                    )
                }
                clouser(allNotification, nil)
            }
        }
    }
    
    
    func addNotificationst(notification: NotificationModel, _ clouser: @escaping (_ success: Bool, _ error: Error?) -> ()) {
        collection.addDocument(data: [
            "notificationGroup": notification.notificationGroup,
            "notificationText": notification.notificationText,
            "notificationTime": notification.notificationTime,
            "notificationTimeStart": notification.notificationTimeStart,
            "notificationTitle": notification.notificationTitle])
        { err in
            if let err = err {
                print("Error adding document: \(err)")
                clouser(false, err)
            } else {
                clouser(true, err)
            }
        }
    }
    

}
