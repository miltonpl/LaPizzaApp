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
    func orderContainerView(navigationPath: Binding<NavigationPath>)-> OrdersContainerView
}

public class OrdersPluginAPI: OrdersAPI {
    let container: Container

    public init(container: Container) {
        self.container = Container(parent: container)
        self.container.registerWithContainer(OrdersCartAPI.self, factory: CartManger.init)
        self.container.register(CartService.self) { _ in OrdersHttpCartService() }
        self.container.register(ItemService.self) { _ in OrdersHttpItemService() }
    }

    public func orderContainerView(navigationPath: Binding<NavigationPath>) -> OrdersContainerView {
        OrdersContainerView(navigationPath: navigationPath, container: container)
    }
}
