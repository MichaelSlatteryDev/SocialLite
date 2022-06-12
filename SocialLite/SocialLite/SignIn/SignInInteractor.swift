//
//  SignInInteractor.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import Foundation

protocol SignInInteractorProtocol {
    func setPresenter(_ presenter: SignInPresenterProtocol)
    func setService(_ interactor: SignInServiceProtocol)
    func signIn(email: String, password: String)
}

final class SignInInteractor: SignInInteractorProtocol {
    
    private var presenter: SignInPresenterProtocol?
    private var service: SignInServiceProtocol?
    
    func setPresenter(_ presenter: SignInPresenterProtocol) {
        self.presenter = presenter
    }
    
    func setService(_ service: SignInServiceProtocol) {
        self.service = service
    }
    
    func signIn(email: String, password: String) {
        service?.signIn(email: email, password: password) { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case let .success(userAccount):
                print(userAccount)
                strongSelf.presenter?.signInSuccess()
            case let .failure(error):
                print(error)
            }
        }
    }
}
