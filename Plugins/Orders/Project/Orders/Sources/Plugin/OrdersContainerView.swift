//
//  OrdersContainerView.swift
//  Orders
//
//  Created by Milton Palaguachi on 5/16/24.
//

import SwiftUI
import Swinject
import Combine

public struct OrdersContainerView: View {
    @Binding 
    private var navigationPath: NavigationPath
    @ObservedObject
    private var dataSource: CartListDataSource

    public init(
        navigationPath: Binding<NavigationPath>,
        container: Container
    ) {
        self._navigationPath = navigationPath
        dataSource = CartListDataSource(container: container)
    }

    public var body: some View {
        ZStack {
            CartListView(dataSource: dataSource)
        }
    }
}

//#Preview {
//    OrdersContainerView(container: Container())
//}
