//
//  CollegeMessangerApp.swift
//  CollegeMessanger
//
//  Created by Денис Большачков on 29.10.2022.
//

import SwiftUI
import FirebaseCore

@main
struct CollegeMessangerApp: App {
    @StateObject var sessionService = SessionServiceImpl()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                switch sessionService.state {
                case .loggedIn:
                    AuthView()
                case .loggedOut:
                    AuthView()
                }
            }
        }
    }
}
