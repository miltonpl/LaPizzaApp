//
//  CartListCoordinator.swift
//  Orders
//
//  Created by Milton Palaguachi on 4/30/23.
//

import Combine
import Designify
import SwiftUI
import Swinject


public class CartListCoordinator: Coordinator {

    @ViewBuilder
    public func build() -> some View {
        Group {
            switch dataSource.state {
                case .initial:
                    EmptyView()
                case .inProgress:
                    ProgressView()
                case .success(let data):
                    CartListView(data: data) { [weak self] in self?.handle(action: $0) }
                case .failure(let error):
                    Text(error.localizedDescription)
            }
        }
    }

    private let dataSource: CartListDataSource
    private var subscribers = Set<AnyCancellable>()

    init(container: Container) {
        self.dataSource = CartListDataSource(container: container)
    }

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
