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
    func getChats(chatID: String, _ clouser: @escaping (_ allChats: CahtModel?, _ error: Error?) -> ())
    func getMessageForChat(chatID: String, _ clouser: @escaping (_ allMessage: [MesagesModel]?, _ error: Error?) -> ())
    func getMessageForChat(chatID: String, messageID: String, _ clouser: @escaping (_ message: MesagesModel?, _ error: Error?) -> ())
}


class ChatServiceImpl: ChatService {
    
    private let collectionChats = Firestore.firestore().collection(FirebaseCollection.chats.rawValue)
    private let collectionUsers = Firestore.firestore().collection(FirebaseCollection.chats.rawValue)
    
    @Inject var sesionUserDefualts: FirebaseAuthService!
    
    
    func getChats(chatID: String, _ clouser: @escaping (_ chat: CahtModel?, _ error: Error?) -> ()) {
        collectionChats.document(chatID).getDocument { snapshot, error in

            if let error = error {
                print("Error getting documents: \(error)")
                clouser(nil, error)
            }else {
                var chat: CahtModel? = nil
                                
                self.getMessageForChat(chatID: chatID) { allMessage, error in
                    
                    chat = CahtModel(
                        messages: allMessage,
                        chatName: snapshot!.data()?["chat_name"] as? String ?? "",
                        chatPicture: snapshot!.data()?["chat_picture"] as? String ?? "",
                        inChat: snapshot!.data()?["inChat"] as? [String] ?? [],
                        notaficationDisabled: snapshot!.data()?["notifications_disabled"] as? [String] ?? [],
                        ownerUID: snapshot!.data()?["owner_uid"] as? String ?? "",
                        reciverUIDs: snapshot!.data()?["receiverUIDs"] as? [String] ?? []
                    )
                    
                    clouser(chat, nil)
                }
            }
        }
    }
    
    
    // Get All messages
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
    
    
    // Get One messages
    func getMessageForChat(chatID: String, messageID: String, _ clouser: @escaping (_ message: MesagesModel?, _ error: Error?) -> ()) {
        Firestore.firestore().collection(FirebaseCollection.chats.rawValue).document(chatID).collection(FirebaseCollection.message.rawValue).document(messageID).getDocument { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
                clouser(nil, error)
            }else {
                var message: MesagesModel? = nil
                
                message = MesagesModel(
                    isReadBy: snapshot!.data()?["isReadBy"] as? [String] ?? [],
                    isReadedBy: snapshot!.data()?["isReadedBy"] as? [String] ?? [],
                    messageFile:  snapshot!.data()?["message_files"] as? [String] ?? [],
                    messagePictures:  snapshot!.data()?["message_pictures"] as? [String] ?? [],
                    messageText: snapshot!.data()?["message_text"] as? String ?? "",
                    messageUID: snapshot!.data()?["message_uid"] as? String ?? "",
                    sender: snapshot!.data()?["sender"] as? String ?? "",
                    senderName: snapshot!.data()?["sender_name"] as? String ?? "",
                    senderPicture: snapshot!.data()?["sender_picture"] as? String ?? "",
                    timestamp: snapshot!.data()?["timestamp"] as? Timestamp
                )
                
                clouser(message, nil)
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
