//
//  TimelineService.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

enum FirebaseEndpoints {
    case postsEndpoint
    case postEndpoint(autoId: String)
    case postCountEndpoint
    
    func value() -> String {
        switch self {
        case .postsEndpoint: return "allPosts/posts/"
        case .postEndpoint(let autoId): return "allPosts/posts/\(autoId)"
        case .postCountEndpoint: return "allPosts/postCount"
        }
    }
}

protocol TimelineServiceProtocol {
    func setInteractor(_ interactor: TimelineInteractorProtocol)
    func addPost(title: String, description: String, completion: @escaping (Post) -> ())
    func getPosts(page: Int, key: String?, completion: @escaping (Int, [Post]) -> ())
    func delete(post: Post, completion: @escaping () -> Void)
    func signOut(completion: @escaping () -> Void)
}

final class TimelineService: TimelineServiceProtocol {
    
    private var interactor: TimelineInteractorProtocol?
    
    private  var ref: DatabaseReference!
    
    init() {
        let url = URLProvider.firebaseRef.url()
        ref = Database.database(url: url).reference()
    }
    
    func setInteractor(_ interactor: TimelineInteractorProtocol) {
        self.interactor = interactor
    }
    
    func addPost(title: String, description: String, completion: @escaping (Post) -> ()) {
        guard let autoId = ref.child(FirebaseEndpoints.postsEndpoint.value()).childByAutoId().key,
              let userId = Auth.auth().currentUser?.uid,
              let userName = Auth.auth().currentUser?.displayName  else {
            return
        }
        
        let post = Post(id: autoId, userId: userId, userName: userName, title: title, description: description, timestamp: Date().timeIntervalSince1970)
        
        ref.child(FirebaseEndpoints.postEndpoint(autoId: autoId).value()).setValue(post.dictionary) { [weak self] error, ref in
                if error == nil {
                    completion(post)
                    self?.ref.child(FirebaseEndpoints.postCountEndpoint.value()).setValue(FirebaseDatabase.ServerValue.increment(1))
                } else {
                    
                }
            }
    }
    
    func getPosts(page: Int, key: String? = nil, completion: @escaping (Int, [Post]) -> ()) {
        
        ref.child(FirebaseEndpoints.postCountEndpoint.value()).getData { [weak self] error, snapshot in
            if error == nil, snapshot?.exists() == true, let totalPosts = snapshot?.value as? Int {
                if let key = key {
                    self?.postsResquest(page: page, with: key, totalPosts: totalPosts, completion: completion)
                } else {
                    self?.initialPostsRequest(page: page, totalPosts: totalPosts, completion: completion)
                }
            }
        }
    }
    
    private func initialPostsRequest(page: Int, totalPosts: Int, completion: @escaping (Int, [Post]) -> ()) {
        ref.child(FirebaseEndpoints.postsEndpoint.value())
            .queryOrderedByKey()
            .queryLimited(toLast: UInt(totalPosts < page ? totalPosts : page))
            .getData { [weak self] error, snapshot in
                guard let strongSelf = self else { return }
                
                completion(totalPosts, strongSelf.decodePosts(error: error, snapshot: snapshot))
            }
    }
    
    private func postsResquest(page: Int, with key: String, totalPosts: Int, completion: @escaping (Int, [Post]) -> ()) {
        ref.child(FirebaseEndpoints.postsEndpoint.value())
            .queryOrderedByKey()
            .queryEnding(atValue: key)
            .queryLimited(toLast: UInt(totalPosts < page ? totalPosts : page))
            .getData { [weak self] error, snapshot in
                guard let strongSelf = self else { return }
                
                completion(totalPosts, strongSelf.decodePosts(error: error, snapshot: snapshot))
            }
    }
    
    private func decodePosts(error: Error?, snapshot: DataSnapshot?) -> [Post] {
        if error == nil, snapshot?.exists() == true, let value = snapshot?.value {
            do {
                let data = try JSONSerialization.data(withJSONObject: value)
                let postResponse = try JSONDecoder().decode([String: Post].self, from: data)
                let posts = postResponse.map { $0.value }.sorted(by: { $0.timestamp >= $1.timestamp })
                
                return posts
            } catch (let error) {
                print(error)
            }
        } else {
            print(error)
        }
        return []
    }
    
    func delete(post: Post, completion: @escaping () -> Void) {
        ref.child(FirebaseEndpoints.postEndpoint(autoId: post.id).value())
            .removeValue { [weak self] error, ref in
            if error == nil {
                completion()
                self?.ref.child(FirebaseEndpoints.postCountEndpoint.value()).setValue(FirebaseDatabase.ServerValue.increment(-1))
            }
        }
    }
    
    func signOut(completion: @escaping () -> Void) {
        do {
            try Auth.auth().signOut()
            completion()
        } catch (let error) {
            print(error)
        }
    }
}

extension DatabaseReference {
    func setValue(post: Post) {
        setValue(post)
    }
}
