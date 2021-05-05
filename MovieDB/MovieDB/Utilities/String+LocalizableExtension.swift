//
//  String+LocalizableExtension.swift
//  MovieDB
//
//  Created by Sayalee Pote on 05/05/21.
//

import Foundation

/// Extension for localizable methods
extension String {
    
    /// Method replaces NSLocalizedString for cleaner use of lcalizable strings
    /// - Returns: The localized string
    public func localized() -> String {
        return localized(tableName: nil, bundle: Bundle.main)
    }
    
    /// Method replaces NSLocalizedString with parameterised optionf or tableName and Bundle
    /// - Parameters:
    ///   - tableName: The receiver's string table to use. If nil it uses "Localizable.strings".
    ///   - bundle: The receiver's bundle name
    /// - Returns: The localized string
    func localized(tableName: String?, bundle: Bundle?) -> String {
        let bundle: Bundle = bundle ?? Bundle.main
        return bundle.localizedString(forKey: self, value: nil, table: tableName)
    }
}
