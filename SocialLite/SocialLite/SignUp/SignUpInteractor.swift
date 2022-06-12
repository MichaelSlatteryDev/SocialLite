//
//  SignUpInteractor.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import Foundation

protocol SignUpInteractorProtocol {
    func setPresenter(_ presenter: SignUpPresenterProtocol)
    func setService(_ interactor: SignUpServiceProtocol)
    func signUp(email: String, password: String, displayName: String)
}

final class SignUpInteractor: SignUpInteractorProtocol {
    
    private var presenter: SignUpPresenterProtocol?
    private var service: SignUpServiceProtocol?
    
    func setPresenter(_ presenter: SignUpPresenterProtocol) {
        self.presenter = presenter
    }
    
    func setService(_ service: SignUpServiceProtocol) {
        self.service = service
    }
    
    func signUp(email: String, password: String, displayName: String) {
        service?.signUp(email: email, password: password, displayName: displayName) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success:
                strongSelf.presenter?.signUpSuccess()
            case .failure:
                strongSelf.presenter?.signUpFail()
            }
        }
    }
}
