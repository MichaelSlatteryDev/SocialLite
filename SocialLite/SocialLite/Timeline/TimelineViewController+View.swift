//
//  TimelineViewController+View.swift
//  SocialLite
//
//  Created by Michael Slattery on 15/06/2022.
//

import UIKit

extension TimelineViewController {
    func setUpSubViews() {
        signOutButton.setTitle("signOut.button".localize(), for: .normal)
        signOutButton.setTitleColor(.red, for: .normal)
        signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        navigationItem.setLeftBarButton(UIBarButtonItem(customView: signOutButton), animated: false)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        addButton.setImage(UIImage(named: "plus"), for: .normal)
        addButton.backgroundColor = .systemBlue
        addButton.layer.cornerRadius = 16.0
        addButton.contentVerticalAlignment = .fill
        addButton.contentHorizontalAlignment = .fill
        addButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        addButton.addTarget(self, action: #selector(addPost), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.view.trailingAnchor.constraint(equalTo: addButton.trailingAnchor, constant: 8.0),
            self.view.bottomAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 24.0),
        ])
    }
}
