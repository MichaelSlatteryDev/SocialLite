//
//  SignInViewController.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import UIKit

protocol SignIn {
    func showSignIn()
}

protocol SignInViewProtocol {
    func setPresenter(_ presenter: SignInPresenterProtocol)
}

final class SignInViewController: UIViewController, SignInViewProtocol {
    
    var presenter: SignInPresenterProtocol?
    
    internal let titleLabel = UILabel()
    internal let containerView = UIView()
    internal let emailTextField = UITextField()
    internal let passwordTextField = UITextField()
    internal let signInButton = UIButton()
    internal let signUpButton = UIButton()
    
    func setPresenter(_ presenter: SignInPresenterProtocol) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        setupSubViews()
    }
    
    @objc func signIn() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        presenter?.signIn(email: email, password: password)
    }
    
    @objc func createAccount() {
        presenter?.createAccount()
    }
}
