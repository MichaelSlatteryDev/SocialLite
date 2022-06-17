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
    func getPosts(page: Int, key: String?, completion: @escaping (Int, [Post]) -> ())
    func delete(post: Post, completion: @escaping () -> Void)
    func signOut()
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
    
    func getPosts(page: Int, key: String? = nil, completion: @escaping (Int, [Post]) -> ()) {
        interactor?.getPosts(page: page, key: key, completion: completion)
    }
    
    func delete(post: Post, completion: @escaping () -> Void) {
        interactor?.delete(post: post, completion: completion)
    }
    
    func signOut() {
        interactor?.signOut { [weak self] in
            self?.coordinator?.showSignIn()
        }
    }
}
