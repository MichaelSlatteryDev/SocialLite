//
//  UIView+Extension.swift
//  SocialLite
//
//  Created by Michael Slattery on 14/06/2022.
//

import UIKit

extension UIView {
    func shake(_ dur:Double) {
        let anim = CABasicAnimation(keyPath: "position")
        anim.duration = dur
        anim.repeatCount = 10
        anim.autoreverses = true
        anim.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5, y: self.center.y))
        anim.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5, y: self.center.y))
        self.layer.add(anim, forKey: "position")
    }
}
