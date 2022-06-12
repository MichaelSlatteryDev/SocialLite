//
//  TimelineInteractor.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import Foundation

protocol TimelineInteractorProtocol {
    func setPresenter(_ presenter: TimelinePresenterProtocol)
    func setService(_ interactor: TimelineServiceProtocol)
}

final class TimelineInteractor: TimelineInteractorProtocol {
    
    private var presenter: TimelinePresenterProtocol?
    private var service: TimelineServiceProtocol?
    
    func setPresenter(_ presenter: TimelinePresenterProtocol) {
        self.presenter = presenter
    }
    
    func setService(_ service: TimelineServiceProtocol) {
        self.service = service
    }
    
}
