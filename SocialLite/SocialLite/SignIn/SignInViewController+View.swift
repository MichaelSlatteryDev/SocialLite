//
//  SignInViewController+View.swift
//  SocialLite
//
//  Created by Michael Slattery on 15/06/2022.
//

import UIKit

extension SignInViewController {
    func setupSubViews() {
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
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        emailTextField.addDoneButtonOnKeyboard()
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(emailTextField)
        
        passwordTextField.placeholder = "signIn.password.placeholder".localize()
        passwordTextField.textContentType = .password
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        emailTextField.spellCheckingType = .no
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.addDoneButtonOnKeyboard()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(passwordTextField)
        
        signInButton.setTitle("signIn.signIn.button".localize(), for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.backgroundColor = .systemBlue
        signInButton.layer.cornerRadius = 4.0
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(signInButton)
        
        signUpButton.setTitle("signIn.signUp.button".localize(), for: .normal)
        signUpButton.setTitleColor(.systemBlue, for: .normal)
        signUpButton.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            self.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            self.view.safeAreaLayoutGuide.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            self.view.safeAreaLayoutGuide.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0),
            containerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: UIScreen.main.bounds.width * 0.1),
            self.view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: UIScreen.main.bounds.width * 0.1),
            
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
    
    func enableSignIn() {
        signInButton.isUserInteractionEnabled = true
        signInButton.backgroundColor = .systemBlue
    }
    
    func disableSignIn() {
        signInButton.isUserInteractionEnabled = false
        signInButton.backgroundColor = .lightGray
    }
}
