//
//  SignUpPresenter.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import Foundation

protocol SignUpPresenterProtocol {
    func setView(_ view: SignUpViewProtocol)
    func setInteractor(_ interactor: SignUpInteractorProtocol)
    func signUp(email: String, password: String, displayName: String)
    func signUpSuccess()
    func signUpFail()
}

final class SignUpPresenter: SignUpPresenterProtocol {
    
    private var view: SignUpViewProtocol?
    private var interactor: SignUpInteractorProtocol?
    
    func setView(_ view: SignUpViewProtocol) {
        self.view = view
    }
    
    func setInteractor(_ interactor: SignUpInteractorProtocol) {
        self.interactor = interactor
    }
    
    func signUp(email: String, password: String, displayName: String) {
        interactor?.signUp(email: email, password: password, displayName: displayName)
    }
    
    func signUpSuccess() {
        view?.signUpSuccess()
    }
    
    func signUpFail() {
        view?.signUpFail()
    }
}
