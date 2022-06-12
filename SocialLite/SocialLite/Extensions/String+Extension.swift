//
//  String+Extension.swift
//  SocialLite
//
//  Created by Michael Slattery on 12/06/2022.
//

import Foundation

extension String {
    func localize() -> String {
        NSLocalizedString(self, comment: "")
    }
}
