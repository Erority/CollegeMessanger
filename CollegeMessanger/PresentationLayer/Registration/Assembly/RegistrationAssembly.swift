//
//  RegistrationAssembly.swift
//  CollegeMessanger
//
//  Created by Денис Большачков on 29.10.2022.
//

import Foundation
import Swinject
import SwiftUI

final class RegistrationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(RegistrationView.self) { r in
            let view = RegistrationView()

            return view
        }
    } 
}
