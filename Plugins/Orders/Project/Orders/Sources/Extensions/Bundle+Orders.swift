//
//  Bundle+Orders.swift
//  Orders
//
//  Created by Milton Palaguachi on 5/12/23.
//

import Foundation
import Designify

private class Orders {}

extension Bundle {
    static var ordersModule: Bundle {
        moduleBundle(for: Orders.self)
    }
}
