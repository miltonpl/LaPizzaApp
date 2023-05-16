//
//  HomeCoordinator.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 5/6/23.
//

import Designify
import Combine
import SwiftUI
import Swinject

extension TabCoordinator {
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
class TabCoordinator: Coordinator {

    @Published var ordersCoordinator: OrdersCoordinator
    @Published var iconsCoordinator: IconsCoordinator
    @Published var screen = Screen.home

    init(container: Container) {
        ordersCoordinator = .init(container: container)
        iconsCoordinator = .init(container: container)
        super.init()
        ordersCoordinator.start()
    }

    @ViewBuilder
    func build(screen: Screen) -> some View {
        switch screen {
            case .cart:
                ordersCoordinator.build()
            case .logo:
                LogoView()
            case .home:
                iconsCoordinator.build()
        }
    }
}
