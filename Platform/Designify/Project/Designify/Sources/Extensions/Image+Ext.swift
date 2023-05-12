//
//  Image+Ext.swift
//  Designify
//
//  Created by Milton Palaguachi on 5/9/23.
//

import SwiftUI

extension Image {
    /// Loads an image from the Designify assets bundle
    public static func coreDImage(named name: String) -> Image {
        Image(name, bundle: .designifyModule)
    }
}
