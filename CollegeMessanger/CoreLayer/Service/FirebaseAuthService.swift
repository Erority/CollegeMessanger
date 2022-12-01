//
//  FirebaseAuthService.swift
//  CollegeMessanger
//
//  Created by Денис Большачков on 09.11.2022.
//

import Combine
import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

protocol FirebaseAuthService {
    func register(model user: User, password: String) -> AnyPublisher<Void, Error>
    func login(with credentials: LoginCredentials ) -> AnyPublisher<Void, Error>
}

final class FirebaseAuthServiceImpl: FirebaseAuthService {
    let auth = Auth.auth()
    
    func register(model user: User, password: String) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { [weak self] promise in
                let exist = false
                // Сheck if a user with this nickname exists
                Firestore.firestore().collection(FirebaseCollection.users.rawValue).whereField(UserCodingKeys.login.rawValue, isEqualTo: user.login)
                    .getDocuments { snapshot, error in
                        if let error = error {
                            print(error.localizedDescription)
                            promise(.failure(error))
                        } else {
                            if (snapshot?.documents.count ?? 0 > 0) {
                                promise(.failure(FirebaseCustomError.userWithLoginExist))
                                return
                            }
                        }
                        
                        self?.auth
                            .createUser(withEmail: user.email, password: password) { [weak self] res, error in
                                if let error = error {
                                    promise(.failure(error))
                                } else {
                                    if let id = res?.user.uid {
                                        let values = [UserCodingKeys.firstName.rawValue: user.firstName,
                                                      UserCodingKeys.lastName.rawValue: user.lastName,
                                                      UserCodingKeys.patronimyc.rawValue: user.patronimyc,
                                                      UserCodingKeys.chats.rawValue: [],
                                                      UserCodingKeys.email.rawValue: user.email,
                                                      UserCodingKeys.login.rawValue: user.login,
                                                      UserCodingKeys.phone.rawValue: user.phone,
                                                      UserCodingKeys.role.rawValue: user.role.rawValue,
                                                      UserCodingKeys.birthday.rawValue: user.birthday,
                                                      UserCodingKeys.profilePicture.rawValue: user.profilePicture,
                                                      UserCodingKeys.group.rawValue: user.group] as [String : Any]
                                        
                                        Firestore.firestore().collection(FirebaseCollection.users.rawValue)
                                            .document(id).setData(values) { [weak self] error in
                                                if let error = error {
                                                    promise(.failure(error))
                                                } else {
                                                    self?.auth.currentUser?.sendEmailVerification()
                                                    promise(.success(()))
                                                }
                                            }
                                    }
                                }
                            }
                    }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
    func login(with credentials: LoginCredentials) -> AnyPublisher<Void, Error> {
        Deferred {
            Future {  [weak self] promise in
                
                self?.auth
                    .signIn(withEmail: credentials.email, password: credentials.password) { res, error in
                        if let error = error {
                            promise(.failure(error))
                        } else {
                            promise(.success(()))
                        }
                    }
                }
            }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}

enum RegistrationKeys: String {
    case firstName
    case lastName
    case group
    case phone
    case role
    case birthday
}
