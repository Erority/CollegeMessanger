//
//  User.swift
//  CollegeMessanger
//
//  Created by Денис Большачков on 12.11.2022.
//

import Foundation

struct User {
    var firstName: String
    var lastName: String
    var patronimyc: String
    var login: String
    var birthday: Date
    var email: String
    var phone: String
    var profilePicture: String
    var role: Role
    var group: String
    var chatIds: [String]?
    var userPlatform: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "FirstName"
        case lastName = "LastName"
        case patronimyc = "Patronymic"
        case email = "Email"
        case login = "Login"
        case birthday = "Birthday"
        case phone = "Phone"
        case profilePicture = "ProfilePicture"
        case role = "Role"
        case group = "Group"
        case chatIds = "ChatIDs"
        case userPlatform = "UserPlatform"
    }
}

enum UserCodingKeys: String {
    case firstName = "FirstName"
    case lastName = "LastName"
    case patronimyc = "Patronymic"
    case email = "Email"
    case login = "Login"
    case birthday = "Birthday"
    case phone = "Phone"
    case profilePicture = "ProfilePicture"
    case role = "Role"
    case group = "Group"
    case chats = "ChatIDs"
    case userPlatform = "UserPlatform"
}

enum Role: String {
    case student = "student"
}

struct Group: Identifiable {
    var id = UUID()
    var name: String
}

extension User {
    static var new: User {
        User(firstName: "",
             lastName: "",
             patronimyc: "",
             login: "",
             birthday: Date(),
             email: "",
             phone: "",
             profilePicture: "https://firebasestorage.googleapis.com/v0/b/messenger-fee7b.appspot.com/o/profilePictures%2Fphoto.jpg?alt=media&token=03e72e93-c73c-419d-99db-3820edd2613b",
             role: .student,
             group: "")
    }
}
