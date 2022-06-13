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
    func addPost()
}

final class TimelineViewController: UIViewController, TimelineViewProtocol {
    
    var presenter: TimelinePresenterProtocol?
    
    private let tableView = UITableView()
    private let addButton = UIButton()
    
    private var posts: [Post] = []
    
    func setPresenter(_ presenter: TimelinePresenterProtocol) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TimelineCell.self, forCellReuseIdentifier: TimelineCell.reuseID)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        setUpSubViews()
        
        if posts.isEmpty {
            
        } else {
            
        }
    }
    
    private func setUpSubViews() {
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
    
    @objc func addPost() {
        let addPostVC = AddPostViewController()
        addPostVC.modalPresentationStyle = .overCurrentContext
        addPostVC.modalTransitionStyle = .crossDissolve
        
        addPostVC.post = { [weak self] title, description in
            guard let strongSelf = self else { return }
            
            strongSelf.presenter?.post(title: title, description: description) { [weak self] post in
                guard let strongSelf = self else { return }
                
                strongSelf.posts.append(post)
                strongSelf.tableView.reloadData()
            }
        }
        
        present(addPostVC, animated: true)
    }
}

extension TimelineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TimelineCell(style: .default, reuseIdentifier: TimelineCell.reuseID)
        
        cell.setData(from: posts[indexPath.row])
        
        return cell
    }
}
