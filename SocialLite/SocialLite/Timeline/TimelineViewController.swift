//
//  TimelineViewController.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import UIKit
import FirebaseAuth

protocol Timeline: AnyObject {
    func showTimeline()
}

protocol TimelineViewProtocol {
    func setPresenter(_ presenter: TimelinePresenterProtocol)
    func addPost()
    func getPosts(key: String?)
    func signOut()
}

final class TimelineViewController: UIViewController, TimelineViewProtocol {
    
    var presenter: TimelinePresenterProtocol?
    
    internal let signOutButton = UIButton()
    internal let tableView = UITableView()
    internal let addButton = UIButton()
    
    private var posts: [Post] = []
    private var postCount: Int = 0
    private var page = 25
    private let pagination = 25
    
    func setPresenter(_ presenter: TimelinePresenterProtocol) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TimelineCell.self, forCellReuseIdentifier: TimelineCell.reuseID)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        setUpSubViews()
        
        if posts.isEmpty {
            
        }
        
        getPosts()
    }
    
    @objc func addPost() {
        let addPostVC = AddPostViewController()
        addPostVC.modalPresentationStyle = .overCurrentContext
        addPostVC.modalTransitionStyle = .crossDissolve
        
        addPostVC.post = { [weak self] title, description in
            guard let strongSelf = self else { return }
            
            strongSelf.presenter?.addPost(title: title, description: description) { [weak self] post in
                guard let strongSelf = self else { return }
                
                strongSelf.postCount += 1
                strongSelf.posts.insert(post, at: 0)
                strongSelf.tableView.reloadData()
            }
        }
        
        present(addPostVC, animated: true)
    }
    
    func getPosts(key: String? = nil) {
        presenter?.getPosts(page: page, key: key) { [weak self] postCount, posts in
            guard let strongSelf = self else { return }

            strongSelf.postCount = postCount
            strongSelf.posts.append(contentsOf: posts)
            strongSelf.tableView.reloadData()
        }
    }
    
    @objc func signOut() {
        presenter?.signOut()
    }
}

extension TimelineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TimelineCell(style: .default, reuseIdentifier: TimelineCell.reuseID)
        
        cell.setData(from: posts[indexPath.row])
        
        if indexPath.row == posts.count - 1 && (page + pagination) < postCount {
            page += pagination
            getPosts(key: posts[indexPath.row].id)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        
        if editingStyle == .delete  {
            self.presenter?.delete(post: post) {
                self.postCount -= 1
                self.posts.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        let post = posts[indexPath.row]
        
        if Auth.auth().currentUser?.uid == post.userId {
            return .delete
        } else {
            return .none
        }
    }
}
