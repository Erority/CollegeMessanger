//
//  InjectPropertyWrapper.swift
//  CollegeMessanger
//
//  Created by Денис Большачков on 06.11.2022.
//

import Foundation

@propertyWrapper
struct Inject<I> {
    let wrappedValue: I
    init() {
        self.wrappedValue = Resolver.shared.resolve(I.self)
    }
}

class Resolver {
    static let shared = Resolver()

    private var container = ApplicationAssemby.defaultContainer
    
    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }
}
