//
//  SignInPresenter.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

protocol SignInPresenterProtocol {
    func setView(_ view: SignInViewProtocol)
    func setInteractor(_ interactor: SignInInteractorProtocol)
    func signIn(email: String, password: String)
}

final class SignInPresenter: SignInPresenterProtocol {
    
    private var view: SignInViewProtocol?
    private var interactor: SignInInteractorProtocol?
    
    func setView(_ view: SignInViewProtocol) {
        self.view = view
    }
    
    func setInteractor(_ interactor: SignInInteractorProtocol) {
        self.interactor = interactor
    }
    
    func signIn(email: String, password: String) {
        interactor?.signIn(email: email, password: password)
    }
}
