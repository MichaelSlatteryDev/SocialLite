//
//  SignInViewController.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import UIKit

protocol SignInViewProtocol {
    func setPresenter(_ presenter: SignInPresenterProtocol)
}

final class SignInViewController: UIViewController, SignInViewProtocol {
    
    var presenter: SignInPresenterProtocol?
    
    private let titleLabel = UILabel()
    private let containerView = UIView()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let signInButton = UIButton()
    private let signUpButton = UIButton()
    
    func setPresenter(_ presenter: SignInPresenterProtocol) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        configureViews()
    }
    
    private func configureViews() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(containerView)
        
        titleLabel.text = "signIn.title".localize()
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)
        
        emailTextField.placeholder = "signIn.email.placeholder".localize()
        emailTextField.textContentType = .emailAddress
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        emailTextField.spellCheckingType = .no
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(emailTextField)
        
        passwordTextField.placeholder = "signIn.password.placeholder".localize()
        passwordTextField.textContentType = .password
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        emailTextField.spellCheckingType = .no
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(passwordTextField)
        
        signInButton.setTitle("signIn.signIn.button".localize(), for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.backgroundColor = .systemBlue
        signInButton.layer.cornerRadius = 4.0
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(signInButton)
        
        signUpButton.setTitle("signIn.signUp.button".localize(), for: .normal)
        signUpButton.setTitleColor(.systemBlue, for: .normal)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 32.0),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            self.view.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            self.view.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0),
            containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: UIScreen.main.bounds.width * 0.1),
            self.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: UIScreen.main.bounds.width * 0.1),
            
            containerView.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: 8.0),
            emailTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8.0),
            containerView.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor, constant: 8.0),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16.0),
            passwordTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8.0),
            containerView.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: 8.0),
            
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16.0),
            signInButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8.0),
            containerView.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor, constant: 8.0),
            signInButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 8.0),
            
            self.view.centerXAnchor.constraint(equalTo: signUpButton.centerXAnchor),
            self.view.bottomAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 32.0),
        ])
    }
    
    @objc func signIn() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        presenter?.signIn(email: email, password: password)
    }
}
