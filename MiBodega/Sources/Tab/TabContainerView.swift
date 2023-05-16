//
//  TabContainerView.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 5/6/23.
//

import SwiftUI
import Swinject

struct TabContainerView: View {
    typealias Screen = TabCoordinator.Screen
    @StateObject var coordinator: TabCoordinator

    var body: some View {
        TabView(selection: $coordinator.screen) {
            coordinator.build(screen: .logo)
                .tabItem { Label(Screen.logo.title, systemImage: Screen.logo.systemImage) }
                .tag(Screen.logo)
            coordinator.build(screen: .home)
                .tabItem { Label(Screen.home.title, systemImage: Screen.home.systemImage) }
                .tag(Screen.home)
            coordinator.build(screen: .cart)
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem { Label(Screen.cart.title, systemImage: Screen.cart.systemImage) }
                .tag(Screen.cart)
        }
    }
}

#if DEBUG
struct HomeCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        TabContainerView(coordinator: .init(container: .debugContainer))
    }
}
#endif
