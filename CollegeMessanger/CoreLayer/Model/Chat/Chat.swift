//
//  Chat.swift
//  CollegeMessanger
//
//  Created by Студент on 19.12.2022.
//

import Foundation


struct CahtModel {
    var messages: [MesagesModel]?
    
    var chatName: String?
    var chatPicture: String?
    var inChat: [String?]?
    var notaficationDisabled: [String?]?
    var ownerUID: String?
    var reciverUIDs: [String?]?

}
