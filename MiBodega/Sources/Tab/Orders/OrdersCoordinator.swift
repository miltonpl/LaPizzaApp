//
//  OrdersCoordinator.swift
//  MiBodega
//
//  Created by Milton Palaguachi on 5/11/23.
//

import Designify
import Swinject
import SwiftUI
import Orders

@MainActor
class OrdersCoordinator: Coordinator {
    @State var shouldReload = false
    @ViewBuilder
    func build() -> some View {
        Group {
            NavigationStack {
                ordersAPI.coordinator.build()

            }
        }
    }

    let ordersAPI: OrdersAPI
    
    init(container: Container) {
        ordersAPI = container.get()
    }

    override func start() {}
}
