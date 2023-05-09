//
//  HomeCoordinator.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 5/6/23.
//

import SwiftUI
import Swinject

extension HomeCoordinator {
    enum HomeTab {
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
class HomeCoordinator: Coordinator {

    @Published var cartListCoordinator: CartListCoordinator
    @Published var featureCoordinator: FeatureCoordinator

    @Published var tab = HomeTab.home

    init(container: Container) {
        cartListCoordinator = .init(container: container)
        featureCoordinator = .init(container: container)
    }

    @ViewBuilder
    func build(tab: HomeTab) -> some View {
        switch tab {
            case .cart:
                cartListCoordinator.build(screen: .cartList)
            case .logo:
                LogoView()
            case .home:
                featureCoordinator.build(feature: .options)
        }
    }
}
