//
//  Double+Extension.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import Foundation

extension Double {
    
    func timeSincePost() -> String {
        let diff = Date().timeIntervalSince1970 - self
        return String(diff)
    }
}
