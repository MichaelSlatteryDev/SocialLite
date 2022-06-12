//
//  UITextField+Extension.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import UIKit

extension UITextField {
    func setErrorText(_ text: String) {
        self.text = ""
        self.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 8.0),
                NSAttributedString.Key.foregroundColor: UIColor.red
            ]
        )
    }
}
