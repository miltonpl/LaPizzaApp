//
//  CartListCoordinator.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 4/30/23.
//

import Foundation
import Combine
import SwiftUI
import Swinject

@MainActor
class CartListCoordinator: Coordinator {
    enum Screen: String, Identifiable {
        case cartList
        var id: String {
            self.rawValue
        }
    }

    @ViewBuilder
    func build(screen: Screen) -> some View {
        switch screen {
            case .cartList:
                NavigationStack {
                    CartListView(dataSource: dataSource) { [weak self] in self?.handle(action: $0) }
                }
        }
    }

    let dataSource: CartListDataSource
    var subscribers = Set<AnyCancellable>()

    init(container: Container) {
        self.dataSource = CartListDataSource(container: container)
    }

    override func start() {}

    func handle(action: CartListView.ActionType) {
        switch action {
            case .update(let itemId, let quantity):
                if quantity < 1 {
                    dataSource.deleteItem(itemId: itemId)
                } else {
                    dataSource.updateItem(itemId: itemId, quantity: quantity)

                }
        }
    }
}
