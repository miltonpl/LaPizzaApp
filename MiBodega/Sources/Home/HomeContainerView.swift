//
//  HomeContainerView.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 5/6/23.
//

import SwiftUI
import Swinject

struct HomeContainerView: View {
    typealias HomeTab = HomeCoordinator.HomeTab
    @StateObject var coordinator: HomeCoordinator

    var body: some View {
        TabView(selection: $coordinator.tab) {
            coordinator.build(tab: .logo)
                .tabItem { Label(HomeTab.logo.title, systemImage: HomeTab.logo.systemImage) }
                .tag(HomeTab.logo)
            coordinator.build(tab: .home)
                .tabItem { Label(HomeTab.home.title, systemImage: HomeTab.home.systemImage) }
                .tag(HomeTab.home)
            coordinator.build(tab: .cart)
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem { Label(HomeTab.cart.title, systemImage: HomeTab.cart.systemImage) }
                .tag(HomeTab.cart)
        }
    }
}

#if DEBUG
struct HomeCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContainerView(coordinator: .init(container: .debugContainer))
    }
}
#endif
