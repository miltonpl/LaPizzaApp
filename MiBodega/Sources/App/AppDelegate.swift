//
//  AppDelegate.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 5/6/23.
//

import Swinject
import UIKit

final class AppDelegate: UIResponder, UIApplicationDelegate {
    let container = Container()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        container.register(PluginAssembly.self) { _ in PluginAssembly() }
        container.registerWithContainer(OrdersCartAPI.self, factory: CartManger.init)
        container.register(CartService.self) { _ in OrdersHttpCartService() }
        container.register(ItemService.self) { _ in OrdersHttpItemService() }
          return true
      }

}
