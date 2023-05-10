//
//  CartManager.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 5/6/23.
//

import Foundation
import Combine
import Swinject

typealias CartResult = AnyPublisher<Cart, Error>

protocol OrdersCartAPI {
    var cart: Cart? { get }
    func getCart() -> CartResult
    func updateItem(itemId: String, quantity: Int) -> CartResult
    func deleteItem(itemId: String) -> CartResult
}

class CartManger: OrdersCartAPI {
    
    
    var cart: Cart? {
        data.cart
    }
    
    @Published
    private var data: Data = Data()
    @Published
    private var state: State = .ready
    
    private let cartService: CartService
    private let itemService: ItemService
    private let container: Container
    
    init(container: Container) {
        self.container = container
        cartService = container.get()
        itemService = container.get()
    }
    
    func getItems() {}
    
    func getCart() -> CartResult {
        if let cart = data.cart {
            return itemService
                .getItems()
                .receive(on: DispatchQueue.main)
                .tryMap { [weak self] in
                    guard let self = self else { throw CartError.noCart }
                    return try self.mapResult(cart: cart, items: $0) }
                .eraseToAnyPublisher()
        }
        return Publishers.Zip(cartService.createdCart(), itemService.getItems())
            .map { $0 }
            .receive(on: DispatchQueue.main)
            .tryMap { response -> Cart in
                return try self.mapResult(responose: (response.0.0, response.1)) }
            .eraseToAnyPublisher()
    }

    func deleteItem(itemId: String) -> CartResult {
        guard let cart = data.cart else {
            return Fail(error: CartError.noCart)
                .eraseToAnyPublisher()
        }

        let updatedItems = cart.items.filter { $0.id != itemId }
        let updatedCart = Cart(id: cart.id, created: cart.created, items: updatedItems)
        data.cart = updatedCart
        return Just(updatedCart)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func updateItem(itemId: String, quantity: Int) -> CartResult {
        guard let cart = data.cart else {
            return Fail(error: CartError.noCart)
                .eraseToAnyPublisher()
        }

        let updatedItems = cart.items.map { item in
            if item.id == itemId {
                return Cart.Item(
                    title: item.title,
                    type: item.type,
                    quantity: quantity,
                    description: item.description,
                    price: item.price,
                    rating: item.rating,
                    id: itemId
                )
            } else {
                return item
            }
        }
        let updatedCart = Cart(id: cart.id, created: cart.created, items: updatedItems)
        data.cart = updatedCart
        return Just(updatedCart)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
extension CartManger {
    private func mapResult(cart: Cart, items: [RawItem]) throws -> Cart {
        let items = items.map({ Cart.Item(raw: $0) })
        let cart = Cart(id: cart.id, created: cart.created, items: items)
        data = .init(cart: cart, state: .created)
        state = .success
        return cart
    }

    private func mapResult(responose: CartResponse) throws -> Cart {
        let (rawCart, rawItems) = responose
        let cart = Cart(id: rawCart.id, created: rawCart.date, items: rawItems.map({ Cart.Item(raw: $0) }))
        data = .init(cart: cart, state: .created)
        return cart
    }

    private func mapResult<T>(_ result: Swift.Result<T, Error>) throws -> Cart {
        switch result {
            case .success(let success):
                guard let raw = success as? RawCart else { throw  CartError.noCart }
                return Cart(id: raw.id, created: raw.date, items: [])
            case .failure(let failure):
                throw failure
        }
    }
}
enum CartError: Error {
    case noCart
    case invalidItemId
}

extension CartManger {
    struct Data {
        var cart: Cart?
        var state: CartState?
    }

    enum State: Equatable {
        case ready, loading, success, failure(Error)

        static func == (lhs: CartManger.State, rhs: CartManger.State) -> Bool {
            switch(lhs, rhs) {
                case (.ready, .ready):
                    return true
                case (.loading, .loading):
                    return true
                case (.success, .success):
                    return true
                case (.failure, .failure):
                    return true
                default:
                    return true
            }
        }
    }
}
