//
//  SignUpService.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

enum URLProvider: String {
    case firebaseRef = "https://sociallite-87616-default-rtdb.europe-west1.firebasedatabase.app"
    
    func url() -> String {
        return self.rawValue
    }
}

protocol SignUpServiceProtocol {
    func setInteractor(_ interactor: SignUpInteractorProtocol)
    func signUp(email: String, password: String, displayName: String, completion: @escaping (Result<UserAccount, Error>) -> ())
}

final class SignUpService: SignUpServiceProtocol {
    
    private var interactor: SignUpInteractorProtocol?
    
    private  var ref: DatabaseReference!
    
    init() {
        let url = URLProvider.firebaseRef.url()
        ref = Database.database(url: url).reference()
    }
    
    func setInteractor(_ interactor: SignUpInteractorProtocol) {
        self.interactor = interactor
    }
    
    func signUp(email: String, password: String, displayName: String, completion: @escaping (Result<UserAccount, Error>) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            
            if error != nil, let error = error as? NSError {
                strongSelf.handleError(error: error, completion: completion)
            } else if let user = authResult?.user {
                let changeRequest = user.createProfileChangeRequest()
                
                changeRequest.displayName = displayName
                changeRequest.commitChanges { _ in
                    strongSelf.ref.child("users/").childByAutoId().setValue(["name": user.displayName, "id": user.uid])
                    completion(.success(UserAccount(displayName: displayName, photoUrl: nil)))
                }
            } else {
                completion(.failure(NSError(domain: "SignUpService", code: 500)))
            }
        }
    }
    
    private func handleError(error: NSError, completion: @escaping (Result<UserAccount, Error>) -> ()) {
        if let errorCode = AuthErrorCode.Code(rawValue: error.code) {
            switch errorCode {
            default:
                print("Handle other errors")
            }
        }
    }
}
