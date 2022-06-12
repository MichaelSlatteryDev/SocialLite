//
//  SignUpViewController.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import UIKit

protocol SignUp: AnyObject {
    func signUp()
}

protocol SignUpViewProtocol {
    func setPresenter(_ presenter: SignUpPresenterProtocol)
}

final class SignUpViewController: UIViewController, SignUpViewProtocol, SignUp {
    
    var presenter: SignUpPresenterProtocol?
    
    weak var coordinator: Coordinators?
    
    private let scrollView = UIScrollView()
    private let createAccountLabel = UILabel()
    private let nameTextField = UITextField()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let createAccountButton = UIButton()
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = .white
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        
        createAccountLabel.text = "Create Account"
        createAccountLabel.font = UIFont.systemFont(ofSize: 20)
        createAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(createAccountLabel)
        
        nameTextField.placeholder = "Display Name"
        nameTextField.textContentType = .name
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(nameTextField)
        
        emailTextField.placeholder = "Email"
        emailTextField.textContentType = .emailAddress
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        emailTextField.spellCheckingType = .no
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(emailTextField)
        
        passwordTextField.placeholder = "Password"
        passwordTextField.textContentType = .password
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        emailTextField.spellCheckingType = .no
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(passwordTextField)
        
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.setTitleColor(.white, for: .normal)
        createAccountButton.backgroundColor = .systemBlue
        createAccountButton.layer.cornerRadius = 4.0
        createAccountButton.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        createAccountButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(createAccountButton)
        
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            self.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            self.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            createAccountLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16.0),
            createAccountLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.0),
            createAccountLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 16.0),
            
            nameTextField.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 16.0),
            nameTextField.leadingAnchor.constraint(equalTo: createAccountLabel.leadingAnchor, constant: 8.0),
            nameTextField.trailingAnchor.constraint(equalTo: createAccountLabel.trailingAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16.0),
            emailTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16.0),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            
            createAccountButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16.0),
            createAccountButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ])
    }
    
    func setPresenter(_ presenter: SignUpPresenterProtocol) {
        self.presenter = presenter
    }
    
    @objc func signUp() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let displayName = nameTextField.text else { return }
        
        presenter?.signUp(email: email, password: password, displayName: displayName)
    }
}
