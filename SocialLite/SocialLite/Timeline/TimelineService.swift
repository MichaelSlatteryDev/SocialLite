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
    func getPosts(completion: @escaping () -> ())
}

final class TimelineService: TimelineServiceProtocol {
    
    private var interactor: TimelineInteractorProtocol?
    
    private  var ref: DatabaseReference!
    
    init() {
        let url = try! NSString(contentsOfFile: "/Users/michaelslattery/Documents/SocialLite.txt", encoding: String.Encoding.utf8.rawValue) as String
        ref = Database.database(url: url).reference()
    }
    
    func setInteractor(_ interactor: TimelineInteractorProtocol) {
        self.interactor = interactor
    }
    
    func addPost(title: String, description: String, completion: @escaping (Post) -> ()) {
        guard let autoId = ref.child("posts/").childByAutoId().key,
              let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let post = Post(id: autoId, userId: userId, title: title, description: description, timestamp: Date().timeIntervalSince1970)
        
        ref.child("posts/\(autoId)/").setValue(post.dictionary) {error, ref in
            
            if error == nil {
                completion(post)
            } else {
                
            }
        }
    }
    
    func getPosts(completion: @escaping () -> ()) {
        ref.child("posts/").getData { [weak self] error, snapshot in
            guard let strongSelf = self else { return }
            
            if error == nil {
                
            } else {
                
            }
        }
    }
}

extension DatabaseReference {
    func setValue(post: Post) {
        setValue(post)
    }
}
