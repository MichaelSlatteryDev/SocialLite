//
//  SignUpViewController+View.swift
//  SocialLite
//
//  Created by Michael Slattery on 15/06/2022.
//

import UIKit

extension SignUpViewController  {
    func setupSubViews() {
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
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            createAccountLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 32.0),
            createAccountLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 16.0),
            stackView.trailingAnchor.constraint(equalTo: createAccountLabel.trailingAnchor, constant: 16.0),
            
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
}
