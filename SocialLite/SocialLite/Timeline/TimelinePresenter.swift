//
//  TimelinePresenter.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import Foundation

protocol TimelinePresenterProtocol {
    var coordinator: Coordinators? { get set }
    
    func setView(_ view: TimelineViewProtocol)
    func setInteractor(_ interactor: TimelineInteractorProtocol)
}

final class TimelinePresenter: TimelinePresenterProtocol {
    
    private var view: TimelineViewProtocol?
    private var interactor: TimelineInteractorProtocol?
    
    weak var coordinator: Coordinators?
    
    func setView(_ view: TimelineViewProtocol) {
        self.view = view
    }
    
    func setInteractor(_ interactor: TimelineInteractorProtocol) {
        self.interactor = interactor
    }
}
