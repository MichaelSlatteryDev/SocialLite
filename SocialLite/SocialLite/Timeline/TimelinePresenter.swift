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
    func addPost(title: String, description: String, completion: @escaping (Post) -> ())
    func getPosts(completion: @escaping ([Post]) -> ())
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
    
    func addPost(title: String, description: String, completion: @escaping (Post) -> ()) {
        interactor?.addPost(title: title, description: description, completion: completion)
    }
    
    func getPosts(completion: @escaping ([Post]) -> ()) {
        interactor?.getPosts(completion: completion)
    }
}
