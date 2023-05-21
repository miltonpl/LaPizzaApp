//
//  Bundel+OrdersMock.swift
//  OrdersMock
//
//  Created by Milton Palaguachi on 5/20/23.
//

import Foundation
import Designify

private class OrdersMock {}

extension Bundle {
    static var ordersMockModule: Bundle {
        moduleBundle(for: OrdersMock.self)
    }
}
