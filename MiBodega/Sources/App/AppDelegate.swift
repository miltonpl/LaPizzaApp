//
//  AppDelegate.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 5/6/23.
//

import Designify
import Swinject
import UIKit

final class AppDelegate: UIResponder, UIApplicationDelegate {
    let container = Container()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        container.register(PluginAssembly.self) { _ in PluginAssembly() }
        container.registerWithContainer(OrdersCartAPI.self, factory: CartManger.init)
//        container.register(DesignifyPluginAPI.self) { _ in DesignifyPlugin()}
        container.registerWithChildContainer(DesignifyPluginAPI.self, factory: DesignifyPlugin.init)
        container.register(CartService.self) { _ in OrdersHttpCartService() }
        container.register(ItemService.self) { _ in OrdersHttpItemService() }
          return true
      }

}
