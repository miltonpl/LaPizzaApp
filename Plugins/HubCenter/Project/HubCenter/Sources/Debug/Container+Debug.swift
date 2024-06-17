//
//  Container+Debug.swift
//  HubCenter
//
//  Created by Milton Palaguachi on 5/15/24.
//

import Foundation
import Swinject

#if DEBUG
extension Container {
    static var debugContainer: Container {
        let container = Container()
//        container.registerWithContainer(OrdersCartAPI.self, factory: CartManger.init)
//        container.register(CartService.self) { _ in OrdersHttpCartService() }
//        container.register(ItemService.self) { _ in OrdersHttpItemService() }
        return container
    }
}
#endif
