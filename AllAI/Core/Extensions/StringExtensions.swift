//
//  StringExtensions.swift
//  AllAI
//
//  Created by hosam abufasha on 28/02/2024.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    func localized(arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
}
