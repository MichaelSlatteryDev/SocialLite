//
//  TimelineService.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

protocol TimelineServiceProtocol {
    func setInteractor(_ interactor: TimelineInteractorProtocol)
    func addPost(title: String, description: String, completion: @escaping (Post) -> ())
    func getPosts(completion: @escaping ([Post]) -> ())
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
        guard let autoId = ref.child("posts/").childByAutoId().key,
              let userId = Auth.auth().currentUser?.uid,
              let userName = Auth.auth().currentUser?.displayName  else {
            return
        }
        
        let post = Post(id: autoId, userId: userId, userName: userName, title: title, description: description, timestamp: Date().timeIntervalSince1970)
        
        ref.child("posts/\(autoId)/").setValue(post.dictionary) {error, ref in
            
            if error == nil {
                completion(post)
            } else {
                
            }
        }
    }
    
    func getPosts(completion: @escaping ([Post]) -> ()) {
        ref.child("posts/").getData { error, snapshot in
            if error == nil, snapshot?.exists() == true, let value = snapshot?.value {
                do {
                    let data = try JSONSerialization.data(withJSONObject: value)
                    let posts = try JSONDecoder().decode([String: Post].self, from: data)
                    let p = posts.map { $0.value }.sorted(by: { $0.timestamp >= $1.timestamp })
                    
                    completion(p)
                } catch (let error) {
                    print(error)
                }
            } else {
                print(error)
            }
        }
    }
    
    func delete(post: Post, completion: @escaping () -> Void) {
        ref.child("posts/\(post.id)").removeValue { error, ref in
            if error == nil {
                completion()
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
