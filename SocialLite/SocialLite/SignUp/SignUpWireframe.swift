//
//  SignUpWireframe.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import Foundation

class SignUpWireframe {
    static func prepareSignUpView(_ view: SignUpViewProtocol, coordinator: Coordinators) {
        var presenter: SignUpPresenterProtocol = SignUpPresenter()
        let interactor: SignUpInteractorProtocol = SignUpInteractor()
        let service: SignUpServiceProtocol = SignUpService()
        
        presenter.coordinator = coordinator
        
        view.setPresenter(presenter)
        presenter.setView(view)
        presenter.setInteractor(interactor)
        interactor.setPresenter(presenter)
        interactor.setService(service)
        service.setInteractor(interactor)
    }
}
