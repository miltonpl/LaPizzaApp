//
//  MainTabCoordinator.swift
//  HubCenter
//
//  Created by Milton Palaguachi on 5/15/24.
//

import MBPlatform
import Designify
import Combine
import SwiftUI
import Swinject
import Orders

extension MainTabCoordinator {
    enum Screen {
        case home
        case logo
        case cart

        var systemImage: String {
            switch self {
                case .home:
                    return "leaf.fill"
                case .logo:
                    return "hare.fill"
                case .cart:
                    return "cart"
            }
        }

        var title: String {
            switch self {
                case .home:
                    return "Home"
                case .logo:
                    return "Logo"
                case .cart:
                    return "Cart"
            }
        }
    }
}

@MainActor
public class MainTabCoordinator: Coordinator {

//    @Published var ordersCoordinator: OrdersCoordinator
//    @Published var iconsCoordinator: IconsCoordinator
    @Published var screen = Screen.home

    let container: Container
    let ordersAPI: OrdersAPI

    public init(container: Container) {
        self.container = container
        ordersAPI = container.get()
//        ordersCoordinator = .init(container: container)
//        iconsCoordinator = .init(container: container)
        super.init()
//        ordersCoordinator.start()
    }

    @ViewBuilder
    func build(screen: Screen) -> some View {
        switch screen {
            case .cart:
//                ordersCoordinator.build()
                cartButtonView
            case .logo:
                Text("Logo")
            case .home:
//                iconsCoordinator.build()
                Text("Home")
        }
    }

    private var cartButtonView: some View {
        DButtonView(
            model: .init(
                title: "Go to order",
                size: .xlarge, font: .title
            ),
            style: .neumorphic,
            action: {}
        )
    }
}
