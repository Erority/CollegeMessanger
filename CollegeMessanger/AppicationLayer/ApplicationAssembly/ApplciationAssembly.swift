//
//  ApplciationAssembly.swift
//  CollegeMessanger
//
//  Created by Денис Большачков on 29.10.2022.
//

import Foundation
import Swinject

final class ApplicationAssemby {
    public static var defaultContainer: Container {
        ApplicationAssemby.assmebler.resolver as! Container
    }

    private static var assmebler: Assembler = {
        let assembler = Assembler()
        assembler.apply(assemblies: modulesAssembly)
        assembler.apply(assemblies: otherAssembly)
        
        return assembler
    }()

    private class var modulesAssembly: [Assembly] {
        [
            RegistrationAssembly()
        ]
    }
    
    private class var otherAssembly: [Assembly] {
        [
            ServiceAssembly()
        ]
    }
}
