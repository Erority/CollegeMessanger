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
    func addMessageDocument(chatID: String, message: MesagesModel,  _ clouser: @escaping (_ messageSended: Bool, _ error: Error?) -> ())
}


class ChatServiceImpl: ChatService {
    
    private let collectionChats = Firestore.firestore().collection(FirebaseCollection.chats.rawValue)
    private let collectionUsers = Firestore.firestore().collection(FirebaseCollection.users.rawValue)
    
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
        collectionChats.document(chatID).collection(FirebaseCollection.message.rawValue).getDocuments { snapshot, error in
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
        collectionChats.document(chatID).collection(FirebaseCollection.message.rawValue).document(messageID).getDocument { snapshot, error in
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
    
    
    func addChatDocument(ownerUserID: String, chat: CahtModel, _ clouser: @escaping (_ success: Bool, _ error: Error?) -> ()){
        let document = collectionChats.addDocument(data: ["chat_name": chat.chatName ?? "" ,
                                          "chat_picture": chat.chatPicture ?? "",
                                          "inChat": chat.inChat ?? [],
                                          "notifications_disabled": chat.notaficationDisabled ?? [],
                                          "owner_uid": chat.ownerUID ?? "",
                                          "receiverUIDs": chat.reciverUIDs ?? []
                                           ]
                                    )
        { error in
            if error != nil{
                print(error!)
                clouser(false, error)
            }else{
                clouser(true, nil)
            }
        }
        
        collectionUsers.document(ownerUserID).getDocument { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            }else {
                var userChatIds = (snapshot?.data()?["ChatIDs"] as? [String] ?? [])
                userChatIds.append(document.documentID)
                
                self.collectionUsers.document(ownerUserID).setData(["ChatIDs": userChatIds], merge: true)
            }
        }
        
    }
    
    
    func addMessageDocument(chatID: String, message: MesagesModel,  _ clouser: @escaping (_ success: Bool, _ error: Error?) -> ()){
        collectionChats.document(chatID).collection(FirebaseCollection.message.rawValue)
            .addDocument(data: [
                "isReadBy": message.isReadBy ?? [],
                "isReadedBy": message.isReadedBy ?? [] ,
                "message_files": message.messageFile ?? [],
                "message_pictures": message.messagePictures ?? [],
                "message_text": message.messageText ?? "",
                "message_uid": message.messageUID ?? "",
                "sender": message.sender ?? "",
                "sender_name": message.senderName ?? "",
                "sender_picture": message.senderPicture ?? "",
                "timestamp": message.timestamp ?? Timestamp()
            ])
        { error in
            if error != nil{
                print(error!)
                clouser(false, error)
            }else{
                clouser(true, nil)
            }
        }
    }
}

