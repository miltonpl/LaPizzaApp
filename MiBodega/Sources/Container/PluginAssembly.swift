//
//  Assembly.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 5/6/23.
//

import Swinject

class PluginAssembly: Assembly {
    func assemble(container: Container) {
        // Register Denpendencies
        container.registerWithContainer(OrdersCartAPI.self, factory: CartManger.init)
    }
}

#if DEBUG
extension Container {
    static var debugContainer: Container {
        let container = Container()
        container.registerWithContainer(OrdersCartAPI.self, factory: CartManger.init)
        container.register(CartService.self) { _ in OrdersHttpCartService() }
        container.register(ItemService.self) { _ in OrdersHttpItemService() }
        return container
    }
}
#endif
