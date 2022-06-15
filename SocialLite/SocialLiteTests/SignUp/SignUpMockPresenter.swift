//
//  SignUpMockPresenter.swift
//  SocialLiteTests
//
//  Created by Michael Slattery on 15/06/2022.
//

import XCTest
@testable import SocialLite

final class SignUpMockPresenter: SignUpPresenterProtocol {
    var coordinator: Coordinators?
    
    func setView(_ view: SignUpViewProtocol) {
        
    }
    
    func setInteractor(_ interactor: SignUpInteractorProtocol) {
        
    }
    
    func signUp(email: String, password: String, displayName: String) {
        
    }
    
    func signUpSuccess() {
        
    }
    
    func signUpFail() {
        
    }
}
