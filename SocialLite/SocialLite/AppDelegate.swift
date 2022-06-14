//
//  AppDelegate.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        signOutOldUser()
        
        Auth.auth().useEmulator(withHost: "localhost", port: 9099)
        
        let navController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navController)
        
        if let user = Auth.auth().currentUser {
            coordinator?.showTimeline()
        } else {
            coordinator?.start()
        }
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

extension AppDelegate{
    func signOutOldUser(){
        if UserDefaults.standard.value(forKey: "isNewuser") == nil {
            do {
                UserDefaults.standard.set(true, forKey: "isNewuser")
                try Auth.auth().signOut()
            } catch(let error) {
                print(error)
            }
        }
    }
}
