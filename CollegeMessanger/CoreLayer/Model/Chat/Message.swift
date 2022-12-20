//
//  Message.swift
//  CollegeMessanger
//
//  Created by Студент on 19.12.2022.
//

import Foundation
import FirebaseFirestore

struct MesagesModel{
    var isReadBy: [String?]?
    var isReadedBy: [String?]?
    var messageFile: [String?]?
    var messagePictures: [String?]?
    var messageText: String?
    var messageUID: String?
    var sender: String?
    var senderName: String?
    var senderPicture: String?
    var timestamp: Timestamp?
}
