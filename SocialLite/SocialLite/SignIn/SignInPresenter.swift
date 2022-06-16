//
//  SignInPresenter.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import Foundation
import FirebaseAuth

protocol SignInPresenterProtocol {
    var coordinator: Coordinators? { get set }
    
    func setView(_ view: SignInViewProtocol)
    func setInteractor(_ interactor: SignInInteractorProtocol)
    func signIn(email: String, password: String)
    func createAccount()
    func signInSuccess()
    func showError(type: AuthErrorCode.Code)
}

final class SignInPresenter: SignInPresenterProtocol {
    
    private var view: SignInViewProtocol?
    private var interactor: SignInInteractorProtocol?
    
    weak var coordinator: Coordinators?
    
    func setView(_ view: SignInViewProtocol) {
        self.view = view
    }
    
    func setInteractor(_ interactor: SignInInteractorProtocol) {
        self.interactor = interactor
    }
    
    func signIn(email: String, password: String) {
        interactor?.signIn(email: email, password: password)
    }
    
    func createAccount() {
        coordinator?.showSignUp()
    }
    
    func signInSuccess() {
        coordinator?.showTimeline()
    }
    
    func showError(type: AuthErrorCode.Code) {
        view?.showError(type: type)
    }
}
