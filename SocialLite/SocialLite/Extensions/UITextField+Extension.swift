//
//  UITextField+Extension.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import UIKit

extension UITextField {
    func setErrorText(_ text: String, size: CGFloat = 8.0) {
        self.text = ""
        self.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: size),
                NSAttributedString.Key.foregroundColor: UIColor.red
            ]
        )
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonTapped() {
        self.resignFirstResponder()
    }
}
