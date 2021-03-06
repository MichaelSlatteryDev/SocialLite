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
    func addPost(title: String, description: String, completion: @escaping (Post) -> ())
    func getPosts(page: Int, key: String?, completion: @escaping (Int, [Post]) -> ())
    func delete(post: Post, completion: @escaping () -> Void)
    func signOut(completion: @escaping () -> Void)
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
    
    func addPost(title: String, description: String, completion: @escaping (Post) -> ()) {
        service?.addPost(title: title, description: description, completion: completion)
    }
    
    func getPosts(page: Int, key: String? = nil, completion: @escaping (Int, [Post]) -> ()) {
        service?.getPosts(page: page, key: key, completion: completion)
    }
    
    func delete(post: Post, completion: @escaping () -> Void) {
        service?.delete(post: post, completion: completion)
    }
    
    func signOut(completion: @escaping () -> Void) {
        service?.signOut(completion: completion)
    }
}
