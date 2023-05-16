//
//  CartListDataSource.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 4/30/23.
//

import Foundation
import Combine
import Swinject

class CartListDataSource: ObservableObject {
    typealias Item = Cart.Item
    struct Data {
        struct Section: Hashable {
            let title: String
            let itemType: Item.ItemType
            let items: [Item]
            let id = UUID().uuidString
        }
    
        var sections: [Section]

        var total: Double {
            let sectionsTotals = sections.map { $0.items.reduce(0) { $0 + $1.price } }
            return sectionsTotals.reduce(0) { $0 + $1 }
        }
    }

    enum State {
        case initial
        case inProgress
        case success(Data)
        case failure(Error)
    }

    @Published var state: State = .initial
    private var subcriptions = Set<AnyCancellable>()

    private let container: Container
    private let cartAPI: OrdersCartAPI

    init(container: Container) {
        self.container = container
        cartAPI = container.get()
        getCart()
    }

    func updateItem(itemId: String, quantity: Int) {
        state = .inProgress
        cartAPI
            .updateItem(itemId: itemId, quantity: quantity)
            .delay(for: 2, scheduler: DispatchQueue.main)
            .sink { [weak self] in
                self?.handleCompletion($0)
            } receiveValue: { [weak self] cart in
                self?.handleValue(cart: cart)
            }.store(in: &subcriptions)
    }

    func deleteItem(itemId: String) {
        cartAPI
            .deleteItem(itemId: itemId)
            .delay(for: 2, scheduler: DispatchQueue.main)
            .sink { [weak self] in
                self?.handleCompletion($0)
            } receiveValue: { [weak self] cart in
                self?.handleValue(cart: cart)
            }.store(in: &subcriptions)
    }

    func getCart() {
        state = .inProgress
        cartAPI
            .getCart()
            .delay(for: 2, scheduler: DispatchQueue.main)
            .sink { [weak self] in
                self?.handleCompletion($0)
            } receiveValue: { [weak self] cart in
                self?.handleValue(cart: cart)
            }.store(in: &subcriptions)
    }

    func handleValue(cart: Cart) {
        var sections = [Data.Section]()
        let dairyItems = cart.items.filter { $0.type == .dairy }
        sections.append(Data.Section(title: "Dairy Items", itemType: .dairy, items: dairyItems))
        
        let fruitItems = cart.items.filter { $0.type == .fruit }
        sections.append(Data.Section(title: "Fruit Items", itemType: .fruit, items: fruitItems))
        
        let vegetableItems = cart.items.filter { $0.type == .vegetable }
        sections.append(Data.Section(title: "Vegetable Items", itemType: .vegetable, items: vegetableItems))
        
        let bakeryItems = cart.items.filter { $0.type == .bakery }
        sections.append(Data.Section(title: "Bakery Items", itemType: .bakery, items: bakeryItems))
        
        let veganItems = cart.items.filter { $0.type == .vegan }
        sections.append(Data.Section(title: "Vegan Items", itemType: .vegan, items: veganItems))
        
        let meatItems = cart.items.filter { $0.type == .meat }
        sections.append(Data.Section(title: "Meat Items", itemType: .meat, items: meatItems))
        state = .success(.init(sections: sections))
    }

    func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        guard case .failure(let error) = completion else { return }
        state = .failure(error)
    }
}
