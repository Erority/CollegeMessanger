//
//  AuthViewModel.swift
//  CollegeMessanger
//
//  Created by Денис Большачков on 01.12.2022.
//

import Foundation
import Combine

enum AuthState {
    case successfull
    case failed(error: Error)
    case na
}

protocol AuthViewModel {
    func login()
    var state: AuthState { get }
    var credentials: LoginCredentials { get }
    var hasErrors: Bool { get }
}

final class AuthViewModelImpl: AuthViewModel, ObservableObject {
    @Published var state: AuthState = .na
    @Published var credentials: LoginCredentials = LoginCredentials.new
    @Published var hasErrors: Bool = false
    @Inject
    var authService: FirebaseAuthService!
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        setupErrorDescription()
    }
    
    func login() {
        authService.login(with: credentials)
            .sink { res in
                switch res {
                case let .failure(error):
                    self.state = .failed(error: error)
                default: break
                }
            } receiveValue: { [weak self] in
                self?.state = .successfull
            }
            .store(in: &subscriptions)

    }
    
    // MARK: Private Methods
    private func setupErrorDescription() {
        $state
            .map { state -> Bool in
                switch state {
                case .successfull, .na:
                    return false
                case .failed:
                    return true
                }
            }
            .assign(to: &$hasErrors )
    }
}
