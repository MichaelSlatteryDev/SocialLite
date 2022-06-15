//
//  SignUpViewControllerTests.swift
//  SocialLiteTests
//
//  Created by Michael Slattery on 15/06/2022.
//

import XCTest
@testable import SocialLite

final class SignUpViewControllerTest: XCTestCase {
    
    var vc: SignUpViewController!
    
    override func setUpWithError() throws {
        self.vc = SignUpViewController()
        vc.setPresenter(SignUpMockPresenter())
        vc.viewDidLoad()
    }
    
    override func tearDownWithError() throws {
        self.vc.viewDidDisappear(false)
        self.vc.presenter = nil
        self.vc = nil
    }
    
    func testSuccesfulSignUp() {
        vc.nameTextField.text = "Test"
        vc.emailTextField.text = "t@t.com"
        vc.passwordTextField.text = "P@ssw0rd"
        
        vc.signUp()
        
        XCTAssertTrue(vc.emailTextField.text?.isValidEmail() ?? false)
        XCTAssertTrue(vc.passwordTextField.text?.isValidPassword() ?? false)
        XCTAssertTrue(vc.emailErrorLabel.isHidden)
        XCTAssertTrue(vc.passwordErrorLabel.isHidden)
    }
    
    func testFailedSignUpEmailError() {
        vc.nameTextField.text = "Test"
        vc.emailTextField.text = "bademail"
        vc.passwordTextField.text = "P@ssw0rd"
        
        vc.signUp()
        
        XCTAssertFalse(vc.emailTextField.text?.isValidEmail() ?? false)
        XCTAssertTrue(vc.passwordTextField.text?.isValidPassword() ?? false)
        XCTAssertFalse(vc.emailErrorLabel.isHidden)
        XCTAssertTrue(vc.passwordErrorLabel.isHidden)
    }
    
    func testFailedSignUpPasswordError() {
        vc.nameTextField.text = "Test"
        vc.emailTextField.text = "t@t.com"
        vc.passwordTextField.text = "badpassword"
        
        vc.signUp()
        
        XCTAssertTrue(vc.emailTextField.text?.isValidEmail() ?? false)
        XCTAssertFalse(vc.passwordTextField.text?.isValidPassword() ?? false)
        XCTAssertTrue(vc.emailErrorLabel.isHidden)
        XCTAssertFalse(vc.passwordErrorLabel.isHidden)
    }

    
    func testFailedSignUpNoValues() {
        vc.nameTextField.text = nil
        vc.emailTextField.text = nil
        vc.passwordTextField.text = nil
        
        vc.signUp()
        
        XCTAssertFalse(vc.emailTextField.text?.isValidEmail() ?? false)
        XCTAssertFalse(vc.passwordTextField.text?.isValidPassword() ?? false)
        XCTAssertFalse(vc.emailErrorLabel.isHidden)
        XCTAssertFalse(vc.passwordErrorLabel.isHidden)
    }
    
    func testFailedSignUp() {
        vc.signUpFail()
        
        XCTAssertEqual(vc.banner?.titleLabel?.text, "signUp.fail.title".localize())
        XCTAssertEqual(vc.banner?.subtitleLabel?.text, "signUp.fail.subtitle".localize())
        XCTAssertEqual(vc.banner?.style, .danger)
    }
}
