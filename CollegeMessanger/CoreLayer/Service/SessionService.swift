//
//  SessionService.swift
//  CollegeMessanger
//
//  Created by Денис Большачков on 13.11.2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

enum SessionState {
    case loggedIn
    case loggedOut
}

protocol SessionService {
    var state: SessionState { get }
    var sessionUserDetails: SessionUserDetails? { get }
    func logout()
}

final class SessionServiceImpl: SessionService, ObservableObject {
    @Published var state: SessionState = .loggedOut
    @Published var sessionUserDetails: SessionUserDetails?
    
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        setupFirebaseAuthHandler()
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
}

private extension SessionServiceImpl {
    func setupFirebaseAuthHandler() {
        handler = Auth
            .auth()
            .addStateDidChangeListener({ [weak self] auth, user in
                guard let self = self else { return }
                
                self.state = user == nil ? .loggedOut : .loggedIn
            })
    }
    
    func handleRefresh(with uid: String) {
        Firestore.firestore().collection(FirebaseCollection.users.rawValue)
            .document(uid)
            .getDocument() { [weak self] snapshot, error in
                if let error = error {
                    self?.state = .loggedOut
                    return print(error)
                } else {
                    guard let self = self,
                          let id = snapshot?.documentID,
                          let value = snapshot?.data(),
                          let firstName = value[UserCodingKeys.firstName.rawValue] as? String,
                          let lastName = value[UserCodingKeys.lastName.rawValue] as? String,
                          let patronimyc = value[UserCodingKeys.patronimyc.rawValue] as? String,
                          let group = value[UserCodingKeys.group.rawValue] as? String,
                          let profilePicture = value[UserCodingKeys.profilePicture.rawValue] as? String
                    else { return }
                    
                    DispatchQueue.main.async {
                        self.sessionUserDetails = SessionUserDetails(
                            id: id,
                            fistName: firstName,
                            lastName: lastName,
                            patronimyc: patronimyc,
                            group: Group(name: group),
                            profilePicture: profilePicture)
                    }
                }
            }
    }
}
