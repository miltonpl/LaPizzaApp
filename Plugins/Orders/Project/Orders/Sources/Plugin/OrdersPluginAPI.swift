//
//  OrdersPluginAPI.swift
//  Orders
//
//  Created by Milton Palaguachi on 5/11/23.
//

import Designify
import SwiftUI
import Swinject

public protocol OrdersAPI {
    var coordinator: CartListCoordinator { get }
    
}

public class OrdersPluginAPI: OrdersAPI {
    public var coordinator: CartListCoordinator
    let container: Container

    public init(container: Container) {
        self.container = Container(parent: container)
        self.container.registerWithContainer(OrdersCartAPI.self, factory: CartManger.init)
        self.container.register(CartService.self) { _ in OrdersHttpCartService() }
        self.container.register(ItemService.self) { _ in OrdersHttpItemService() }
        coordinator = CartListCoordinator(container: self.container)
    }
}
