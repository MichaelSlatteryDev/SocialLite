//
//  SignUpWireframe.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import Foundation

class SignUpWireframe {
    static func prepareSignUpView(_ view: SignUpViewProtocol, service: SignUpServiceProtocol) {
        let presenter: SignUpPresenterProtocol = SignUpPresenter()
        let interactor: SignUpInteractorProtocol = SignUpInteractor()
        
        view.setPresenter(presenter)
        presenter.setView(view)
        presenter.setInteractor(interactor)
        interactor.setPresenter(presenter)
        interactor.setService(service)
        service.setInteractor(interactor)
    }
}
