//
//  SignUpViewController.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import UIKit
import NotificationBannerSwift

protocol SignUp: AnyObject {
    func showSignUp()
    func showSignUpSuccessBanner()
}

protocol SignUpViewProtocol {
    func setPresenter(_ presenter: SignUpPresenterProtocol)
    func signUpFail()
}

final class SignUpViewController: UIViewController, SignUpViewProtocol {
    
    var presenter: SignUpPresenterProtocol?
    
    internal let stackView = UIStackView()
    internal let createAccountLabel = UILabel()
    internal let nameTextField = UITextField()
    internal let emailTextField = UITextField()
    internal let emailErrorLabel = UILabel()
    internal let passwordTextField = UITextField()
    internal let passwordErrorLabel = UILabel()
    internal let createAccountButton = UIButton()
    
    internal var banner: NotificationBanner?
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = .white
        
        setupSubViews()
    }
    
    func setPresenter(_ presenter: SignUpPresenterProtocol) {
        self.presenter = presenter
    }
    
    @objc func signUp() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let displayName = nameTextField.text ?? ""
        
        guard email.isValidEmail(), password.isValidPassword(), displayName.count > 0 else {
            if !email.isValidEmail() {
                emailErrorLabel.text = "signUp.invalidEmail.text".localize()
                emailErrorLabel.isHidden = false
            } else {
                emailErrorLabel.text = ""
                emailErrorLabel.isHidden = true
            }
            
            if !password.isValidPassword() {
                passwordErrorLabel.text = "signUp.invalidPassword.text".localize()
                passwordErrorLabel.isHidden = false
            } else {
                passwordErrorLabel.text = ""
                passwordErrorLabel.isHidden = true
            }
            
            return
        }
        
        presenter?.signUp(email: email, password: password, displayName: displayName)
    }
    
    func signUpFail() {
        banner = NotificationBanner(title: "signUp.fail.title".localize(), subtitle: "signUp.fail.subtitle".localize(), style: .danger)
        banner?.show()
    }
}
