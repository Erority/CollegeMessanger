//
//  ChatService.swift
//  CollegeMessanger
//
//  Created by Студент on 15.12.2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore


protocol ChatService {
    func getAllChats(_ clouser: @escaping (_ allPosts: [CahtModel]?, _ error: Error?) -> ())
    func getMessageForChat(chatID: String, _ clouser: @escaping (_ allMessage: [MesagesModel]?, _ error: Error?) -> ())
}


class ChatServiceImpl: ChatService {
    
    private let collectionChats = Firestore.firestore().collection(FirebaseCollection.chats.rawValue)
    private let collectionUsers = Firestore.firestore().collection(FirebaseCollection.chats.rawValue)
    
    @Inject var sesionUserDefualts: FirebaseAuthService!
    
    
    func getAllChats(_ clouser: @escaping (_ allPosts: [CahtModel]?, _ error: Error?) -> ()) {
        collectionChats.getDocuments { snapshot, error in

            if let error = error {
                print("Error getting documents: \(error)")
                clouser(nil, error)
            }else {
                var allChats: [CahtModel] = []

                for document in snapshot!.documents {
                    self.getMessageForChat(chatID: document.documentID) { allMessage, error in
                        
                        allChats.append(CahtModel(
                            messages: allMessage,
                            chatName: document.data()["chat_name"] as? String ?? "",
                            chatPicture: document.data()["chat_picture"] as? String ?? "",
                            inChat: document.data()["inChat"] as? [String] ?? [],
                            notaficationDisabled: document.data()["notifications_disabled"] as? [String] ?? [],
                            ownerUID: document.data()["owner_uid"] as? String ?? "",
                            reciverUIDs: document.data()["receiverUIDs"] as? [String] ?? []
                        ))
                    }
                }
                clouser(allChats, nil)
            }
        }
    }
    
    
    func getMessageForChat(chatID: String, _ clouser: @escaping (_ allMessage: [MesagesModel]?, _ error: Error?) -> ()) {
        Firestore.firestore().collection(FirebaseCollection.chats.rawValue).document(chatID).collection(FirebaseCollection.message.rawValue).getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
                clouser(nil, error)
            }else {
                var messages: [MesagesModel] = []
                
                for document in snapshot!.documents {
                    messages.append(MesagesModel(
                        isReadBy: document.data()["isReadBy"] as? [String] ?? [],
                        isReadedBy: document.data()["isReadedBy"] as? [String] ?? [],
                        messageFile:  document.data()["message_files"] as? [String] ?? [],
                        messagePictures:  document.data()["message_pictures"] as? [String] ?? [],
                        messageText: document.data()["message_text"] as? String ?? "",
                        messageUID: document.data()["message_uid"] as? String ?? "",
                        sender: document.data()["sender"] as? String ?? "",
                        senderName: document.data()["sender_name"] as? String ?? "",
                        senderPicture: document.data()["sender_picture"] as? String ?? "",
                        timestamp: document.data()["timestamp"] as? Timestamp
                    ))
                }
                clouser(messages, nil)
            }
        }
    }
    
}


struct CahtModel {
    var messages: [MesagesModel]?
    
    var chatName: String?
    var chatPicture: String?
    var inChat: [String?]?
    var notaficationDisabled: [String?]?
    var ownerUID: String?
    var reciverUIDs: [String?]?

}

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
