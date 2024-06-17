//
//  AppDelegate.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 5/6/23.
//

import Designify
import Swinject
import UIKit
import Orders

final class AppDelegate: UIResponder, UIApplicationDelegate {
    let container = Container()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        registerDependencies()
        return true
    }

    private func registerDependencies() {
        //        container.register(PluginAssembly.self) { _ in PluginAssembly() }
        container.register(DesignifyPluginAPI.self) {_ in DesignifyPlugin()}
        container.registerWithChildContainer(OrdersAPI.self, factory: OrdersPluginAPI.init)
        
    }
}
