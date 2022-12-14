//
//  Error.swift
//  CollegeMessanger
//
//  Created by Денис Большачков on 14.11.2022.
//

import Foundation

enum FirebaseCustomError: Error {
    case userWithLoginExist
}

extension FirebaseCustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .userWithLoginExist:
            return NSLocalizedString(
                "User with that login exist",
                comment: "Choose another login"
            )
        }
    }
}

