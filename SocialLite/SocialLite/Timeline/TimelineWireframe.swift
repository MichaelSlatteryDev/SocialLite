//
//  TimelineWireframe.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import Foundation

class TimelineWireframe {
    static func prepareTimelineView(_ view: TimelineViewProtocol, coordinator: Coordinators) {
        var presenter: TimelinePresenterProtocol = TimelinePresenter()
        let interactor: TimelineInteractorProtocol = TimelineInteractor()
        let service: TimelineServiceProtocol = TimelineService()
        
        presenter.coordinator = coordinator
        
        view.setPresenter(presenter)
        presenter.setView(view)
        presenter.setInteractor(interactor)
        interactor.setPresenter(presenter)
        interactor.setService(service)
        service.setInteractor(interactor)
    }
}
