//
//  TimelineCell.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import UIKit

final class TimelineCell: UITableViewCell {
    
    public static let reuseID = "TimelineCell"
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let timestampLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(titleLabel)
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(descriptionLabel)
        
        timestampLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(timestampLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8.0),
            
            timestampLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            timestampLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8.0),
            self.contentView.trailingAnchor.constraint(equalTo: timestampLabel.trailingAnchor, constant: 8.0),
            timestampLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            
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
        titleLabel.text = post.title
        descriptionLabel.text = post.description
        timestampLabel.text = post.timestamp.timeSincePost()
    }
}
