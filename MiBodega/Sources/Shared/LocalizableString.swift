//
//  LocalizableStrings.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 4/29/23.
//

import Foundation
import SwiftUI

enum LocalizableString {
    case homeTitle
    case homeBody
    case homeFooterTitle
    case homeGreeding
    case homeOrderTitle
    case orderTotalTitle
}

extension LocalizableString {
    private var key: String {
        let key = String(describing: self)
        if let index = key.firstIndex(of: "(") {
            return String(key[..<index])
        }
        return key
    }

    var value: String {
        let value = NSLocalizedString(key, tableName: "Localizable", bundle: .main, comment: "")
        precondition(value != key, "No localized string foun for `\(key)`")
        
        switch self {
            default:
                return value
        }
    }
}

extension String {
    static func localized(_ localize: LocalizableString) -> String {
        localize.value
    }
}

extension Text {
    init(_ localize: LocalizableString) {
        self.init(verbatim: .localized(localize))
    }
}
