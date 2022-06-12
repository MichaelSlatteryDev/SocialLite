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
    
    private let stackView = UIStackView()
    private let createAccountLabel = UILabel()
    private let nameTextField = UITextField()
    private let emailTextField = UITextField()
    private let emailErrorLabel = UILabel()
    private let passwordTextField = UITextField()
    private let passwordErrorLabel = UILabel()
    private let createAccountButton = UIButton()
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = .white
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        createAccountLabel.text = "signUp.title".localize()
        createAccountLabel.font = UIFont.systemFont(ofSize: 20)
        createAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addSubview(createAccountLabel)
        
        nameTextField.placeholder = "signUp.displayName.placeholder".localize()
        nameTextField.textContentType = .name
        nameTextField.autocorrectionType = .no
        nameTextField.autocapitalizationType = .none
        nameTextField.spellCheckingType = .no
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        stackView.addSubview(nameTextField)
        
        emailTextField.placeholder = "signUp.email.placeholder".localize()
        emailTextField.textContentType = .emailAddress
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        emailTextField.spellCheckingType = .no
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        stackView.addSubview(emailTextField)
        
        emailErrorLabel.font = UIFont.systemFont(ofSize: 12)
        emailErrorLabel.textColor = .red
        emailErrorLabel.numberOfLines = 0
        emailErrorLabel.isHidden = true
        emailErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addSubview(emailErrorLabel)
        
        passwordTextField.placeholder = "signUp.password.placeholder".localize()
        passwordTextField.textContentType = .password
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        emailTextField.spellCheckingType = .no
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        stackView.addSubview(passwordTextField)
        
        passwordErrorLabel.font = UIFont.systemFont(ofSize: 12)
        passwordErrorLabel.textColor = .red
        passwordErrorLabel.numberOfLines = 0
        passwordErrorLabel.lineBreakMode = .byTruncatingTail
        passwordErrorLabel.isHidden = true
        passwordErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addSubview(passwordErrorLabel)
        
        createAccountButton.setTitle("signUp.createAccount.button".localize(), for: .normal)
        createAccountButton.setTitleColor(.white, for: .normal)
        createAccountButton.backgroundColor = .systemBlue
        createAccountButton.layer.cornerRadius = 4.0
        createAccountButton.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        createAccountButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addSubview(createAccountButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 64.0),
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            createAccountLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 16.0),
            createAccountLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16.0),
            createAccountLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 16.0),
            
            nameTextField.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 16.0),
            nameTextField.leadingAnchor.constraint(equalTo: createAccountLabel.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: createAccountLabel.trailingAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16.0),
            emailTextField.leadingAnchor.constraint(equalTo: createAccountLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: createAccountLabel.trailingAnchor),
            
            emailErrorLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
            emailErrorLabel.leadingAnchor.constraint(equalTo: createAccountLabel.leadingAnchor),
            emailErrorLabel.trailingAnchor.constraint(equalTo: createAccountLabel.trailingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: emailErrorLabel.bottomAnchor, constant: 16.0),
            passwordTextField.leadingAnchor.constraint(equalTo: createAccountLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: createAccountLabel.trailingAnchor),
            
            passwordErrorLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor),
            passwordErrorLabel.leadingAnchor.constraint(equalTo: createAccountLabel.leadingAnchor),
            passwordErrorLabel.trailingAnchor.constraint(equalTo: createAccountLabel.trailingAnchor),
            
            createAccountButton.topAnchor.constraint(equalTo: passwordErrorLabel.bottomAnchor, constant: 16.0),
            createAccountButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
        ])
    }
    
    func setPresenter(_ presenter: SignUpPresenterProtocol) {
        self.presenter = presenter
    }
    
    @objc func signUp() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let displayName = nameTextField.text else { return }
        
        guard email.isValidEmail(), password.isValidPassword() else {
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
        let banner = NotificationBanner(title: "signUp.fail.title".localize(), subtitle: "signUp.fail.subtitle".localize(), style: .success)
        banner.show()
    }
}
