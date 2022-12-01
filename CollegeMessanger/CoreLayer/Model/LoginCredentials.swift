//
//  LoginCredentials.swift
//  CollegeMessanger
//
//  Created by Денис Большачков on 01.12.2022.
//

import Foundation

struct LoginCredentials {
    var email: String
    var password: String
}

extension LoginCredentials {
    static var new = LoginCredentials(email: "", password: "")
}
