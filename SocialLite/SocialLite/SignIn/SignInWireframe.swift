//
//  SignInWireframe.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

class SignInWireframe {
    static func prepareSignInView(_ view: SignInViewProtocol, coordinator: Coordinators) {
        var presenter: SignInPresenterProtocol = SignInPresenter()
        let interactor: SignInInteractorProtocol = SignInInteractor()
        let service: SignInServiceProtocol = SignInService()
        
        presenter.coordinator = coordinator
        
        view.setPresenter(presenter)
        presenter.setView(view)
        presenter.setInteractor(interactor)
        interactor.setPresenter(presenter)
        interactor.setService(service)
        service.setInteractor(interactor)
    }
}
