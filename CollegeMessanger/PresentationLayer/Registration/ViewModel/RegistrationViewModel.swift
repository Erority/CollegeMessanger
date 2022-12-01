//
//  RegistrationViewModel.swift
//  CollegeMessanger
//
//  Created by Денис Большачков on 29.10.2022.
//

import Foundation
import Combine

enum RegistrationState {
    case successful
    case failed(error: Error)
    case na
}

protocol RegistrationViewModel {
    var state: RegistrationState { get }
    var userDetails: User { get }
    var groups: [Group] { get }
    var hasErrors: Bool { get }
    func registerUser(password: String)
    func fetchGroups()
}

final class RegistrationViewModelImpl: RegistrationViewModel, ObservableObject {
    // MARK: Public Properties
    @Inject
    var registrationService: FirebaseAuthService!
    @Published var state: RegistrationState = .na
    @Published var hasErrors: Bool = false
    var userDetails: User = User.new
    var groups: [Group] = []
    
    init() {
        setupErrorDescription()
    }
    
    //MARK: Private Properties
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Public Methods
    func registerUser(password: String) {
        //TODO: Validation
        
        registrationService.register(model: userDetails, password: password)
            .sink { [weak self] res in
                switch res {
                case let .failure(error):
                    self?.state = .failed(error: error)
                default: break
                }
            } receiveValue: { [weak self] in
                self?.state = .successful
            }
            .store(in: &subscriptions)
    }
    
    func fetchGroups() {
        groups.append(Group(name: "Не выбранна"))
    }
    
    // MARK: Private Methods
    private func setupErrorDescription() {
        $state
            .map { state -> Bool in
                switch state {
                case .successful, .na:
                    return false
                case .failed:
                    return true
                }
            }
            .assign(to: &$hasErrors)
    }
}
