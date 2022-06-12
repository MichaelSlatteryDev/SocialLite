//
//  AppDelegate.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let vc = SignInViewController()
        SignInWireframe.prepareSignInView(vc, service: SignInService())
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        
        return true
    }


}

