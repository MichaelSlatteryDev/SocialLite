//
//  SignInViewController.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import UIKit
import FirebaseAuth

protocol SignIn {
    func showSignIn()
}

protocol SignInViewProtocol {
    func setPresenter(_ presenter: SignInPresenterProtocol)
    func showError(type: AuthErrorCode.Code)
}

final class SignInViewController: UIViewController, SignInViewProtocol {
    
    var presenter: SignInPresenterProtocol?
    
    internal let titleLabel = UILabel()
    internal let containerView = UIView()
    internal let emailTextField = UITextField()
    internal let passwordTextField = UITextField()
    internal let signInButton = LoadingButton()
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
        
        signInButton.showLoading()
        presenter?.signIn(email: email, password: password)
    }
    
    @objc func createAccount() {
        presenter?.createAccount()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        enableSignIn()
    }
    
    func showError(type: AuthErrorCode.Code) {
        signInButton.hideLoading()
        disableSignIn()
        switch type {
        case .invalidEmail:
            emailTextField.text = ""
            emailTextField.setErrorText("signIn.email.errorText".localize(), size: 16.0)
        case .wrongPassword:
            passwordTextField.text = ""
            passwordTextField.setErrorText("signIn.email.passwordText".localize(), size: 16.0)
        default:
            print("Handle other errors")
        }
    }
}
