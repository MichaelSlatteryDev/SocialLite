//
//  SignInWireframe.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

class SignInWireframe {
    static func prepareSignInView(_ view: SignInViewProtocol, service: SignInServiceProtocol) {
        let presenter: SignInPresenterProtocol = SignInPresenter()
        let interactor: SignInInteractorProtocol = SignInInteractor()
        
        view.setPresenter(presenter)
        presenter.setView(view)
        presenter.setInteractor(interactor)
        interactor.setPresenter(presenter)
        interactor.setService(service)
        service.setInteractor(interactor)
    }
}
