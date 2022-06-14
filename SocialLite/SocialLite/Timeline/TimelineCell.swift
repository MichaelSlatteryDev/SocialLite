//
//  TimelineCell.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import UIKit

final class TimelineCell: UITableViewCell {
    
    public static let reuseID = "TimelineCell"
    
    private let userNameLabel = UILabel()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let timestampLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(userNameLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(titleLabel)
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(descriptionLabel)
        
        timestampLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(timestampLabel)
        
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            userNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8.0),
            
            timestampLabel.topAnchor.constraint(equalTo: userNameLabel.topAnchor),
            timestampLabel.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: 8.0),
            self.contentView.trailingAnchor.constraint(equalTo: timestampLabel.trailingAnchor, constant: 8.0),
            timestampLabel.bottomAnchor.constraint(equalTo: userNameLabel.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8.0),
            titleLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8.0),
            self.contentView.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: 8.0),
            self.contentView.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8.0),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(from post: Post) {
        userNameLabel.text = post.userName
        titleLabel.text = post.title
        descriptionLabel.text = post.description
        timestampLabel.text = post.timestamp.timeSincePost()
    }
}
