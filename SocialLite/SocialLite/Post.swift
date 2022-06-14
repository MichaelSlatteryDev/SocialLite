//
//  Post.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import Foundation

struct Post: Codable {
    let id: String
    let userId: String
    let userName: String
    let title: String
    let description: String
    let timestamp: Double
}
