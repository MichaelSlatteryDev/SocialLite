//
//  Double+Extension.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import Foundation

extension Double {
    
    func timeSincePost() -> String {
        let previousDate = Date(timeIntervalSince1970: self)
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.maximumUnitCount = 1
        let time = formatter.string(from: previousDate, to: Date()) ?? ""
        
        return time == "0 seconds" ? "post.time.now".localize() : time + "post.time.ago".localize()
    }
}
