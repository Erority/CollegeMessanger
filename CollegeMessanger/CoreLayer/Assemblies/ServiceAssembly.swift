//
//  ServiceAssembly.swift
//  CollegeMessanger
//
//  Created by Денис Большачков on 12.11.2022.
//

import Foundation
import Swinject

class ServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(FirebaseAuthService.self) { r in
            FirebaseAuthServiceImpl()
        }
        .inObjectScope(.transient)
        
        
        container.register(PostService.self) { r in
            PostServiceImpl()
        }
        .inObjectScope(.transient)
        
        
        container.register(ChatService.self) { r in
            ChatServiceImpl()
        }
        .inObjectScope(.transient)
        
        
        container.register(NotificationsService.self) { r in
            NotificationsServiceImpl()
        }
        .inObjectScope(.transient)
        
        
        container.register(WorkService.self) { r in
            WorkServiceImpl()
        }
        .inObjectScope(.transient)
    }
}
