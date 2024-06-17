//
//  MainTabContainerView.swift
//  HubCenter
//
//  Created by Milton Palaguachi on 5/15/24.
//

import SwiftUI

public struct MainTabContainerView: View {
    typealias Screen = MainTabCoordinator.Screen
    @ObservedObject var coordinator: MainTabCoordinator
    @Binding var navigationPath: NavigationPath


    public init(navigationPath: Binding<NavigationPath>,
                coordinator: MainTabCoordinator) {
        self._navigationPath = navigationPath
        self.coordinator = coordinator
    }

    public var body: some View {
        TabView(selection: $coordinator.screen) {
            coordinator.build(screen: .logo)
                .tabItem { Label(Screen.logo.title, systemImage: Screen.logo.systemImage) }
                .tag(Screen.logo)
            coordinator.build(screen: .home)
                .tabItem { Label(Screen.home.title, systemImage: Screen.home.systemImage) }
                .tag(Screen.home)
            build(screen: .cart)
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem { Label(Screen.cart.title, systemImage: Screen.cart.systemImage) }
                .tag(Screen.cart)
        }
    }

    @ViewBuilder
    private func build(screen: Screen) -> some View {
        switch screen {
            case .cart:
                NavigationView {
                    VStack {
                        NavigationLink(destination: coordinator.ordersAPI.orderContainerView(navigationPath: $navigationPath)) {
                            Text("Go to order")
                        }
                    }
                }
               
            case .logo:
                Text("Logo")
            case .home:
//                iconsCoordinator.build()
                Text("Home")
        }
    }
}

#if DEBUG
//#Preview {
//    MainTabContainerView(coordinator: .init(container: .debugContainer), navigationPath: .)
//}

#endif
