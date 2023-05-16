//
//  EdgeInsets+Ext.swift
//  Orders
//
//  Created by Milton Palaguachi on 4/29/23.
//

import SwiftUI

extension EdgeInsets {
    /// Initilized with uniformInset all edged
    /// - Parameter inset: The unifor inset value
    init(uniformInset inset: CGFloat) {
        self.init(top: inset, leading: inset, bottom: inset, trailing: inset)
    }
}
