//
//  TimelineViewController.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import UIKit

protocol Timeline: AnyObject {
    func showTimeline()
}

protocol TimelineViewProtocol {
    func setPresenter(_ presenter: TimelinePresenterProtocol)
}

final class TimelineViewController: UIViewController, TimelineViewProtocol {
    
    var presenter: TimelinePresenterProtocol?
    
    func setPresenter(_ presenter: TimelinePresenterProtocol) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
}
