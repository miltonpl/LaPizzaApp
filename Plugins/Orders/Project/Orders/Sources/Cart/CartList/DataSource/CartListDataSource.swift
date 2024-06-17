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
            let sectionsTotals = sections.map { $0.items.reduce(0) { $0 + $1.total } }
            return sectionsTotals.reduce(0) { $0 + $1 }
        }
    }

    enum State: Equatable {
        static func == (lhs: CartListDataSource.State, rhs: CartListDataSource.State) -> Bool {
            switch (lhs, rhs) {
                case (.initial,  .initial):
                    return true
                case (.inProgress, .inProgress):
                    return true
                case (.success(let lhsTotal), .success(let rhsTotal)):
                    return lhsTotal == rhsTotal
                case (.failure(let lhsError), .failure(let rhsError)):
                    return lhsError.localizedDescription == rhsError.localizedDescription
                default:
                    return false
            }
        }
        
        case initial
        case inProgress
        case success(total: Double)
        case failure(Error)
    }

    @Published var state: State = .initial
    @Published var data: Data = .init(sections: [])
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
        state = .inProgress
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
        data = Data(sections: sections)
        print("CartListDataSource total: \(data.total)")
        state = .success(total: data.total)
    }

    func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        guard case .failure(let error) = completion else { return }
        state = .failure(error)
    }
}
