//
//  SignInService.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import Foundation
import FirebaseAuth

public typealias UserAccount = (displayName: String, photoUrl: URL?)

protocol SignInServiceProtocol {
    func setInteractor(_ interactor: SignInInteractorProtocol)
    func signIn(email: String, password: String, completion: @escaping (Result<UserAccount, Error>) -> ())
}

final class SignInService: SignInServiceProtocol {
    
    private var interactor: SignInInteractorProtocol?
    
    func setInteractor(_ interactor: SignInInteractorProtocol) {
        self.interactor = interactor
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<UserAccount, Error>) -> ()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            
            if error != nil, let error = error as? NSError {
                strongSelf.handleError(error: error, completion: completion)
            } else if let user = authResult?.user, let name = user.displayName {
                completion(.success(UserAccount(displayName: name, photoUrl: user.photoURL)))
            } else {
                completion(.failure(NSError(domain: "SignInService", code: 500)))
            }
        }
    }
    
    private func handleError(error: NSError, completion: @escaping (Result<UserAccount, Error>) -> ()) {
        if let errorCode = AuthErrorCode.Code(rawValue: error.code) {
            switch errorCode {
            case .invalidEmail:
                print("Handle invalid email")
            case .wrongPassword:
                print("Handle wrong password")
            default:
                print("Handle other errors")
            }
        }
    }
}
