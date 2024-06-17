//
//  CartListCoordinator.swift
//  Orders
//
//  Created by Milton Palaguachi on 4/30/23.
//

import Combine
import MBPlatform
import SwiftUI
import Swinject


public class CartListCoordinator: Coordinator {

    private let dataSource: CartListDataSource
    private var subscribers = Set<AnyCancellable>()

    init(container: Container) {
        self.dataSource = CartListDataSource(container: container)
    }
}
