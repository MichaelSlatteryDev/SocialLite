//
//  Coordinator.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import UIKit
import NotificationBannerSwift

typealias Coordinators = (SignUp & Timeline)

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

final class MainCoordinator: Coordinator, SignUp, Timeline {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SignInViewController()
        SignInWireframe.prepareSignInView(vc, coordinator: self)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showSignUp() {
        let vc = SignUpViewController()
        SignUpWireframe.prepareSignUpView(vc, coordinator: self)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showSignUpSuccessBanner() {
        navigationController.popViewController(animated: false)
        let banner = NotificationBanner(title: "signUp.success.title".localize(), subtitle: "signUp.success.subtitle".localize(), style: .success)
        banner.show()
    }
    
    func showTimeline() {
        let vc = TimelineViewController()
        TimelineWireframe.prepareTimelineView(vc, coordinator: self)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showAddPostModal() {
        
    }
}
