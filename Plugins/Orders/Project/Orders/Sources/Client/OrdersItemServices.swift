//
//  OrdersItemServices.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 5/6/23.
//

import Combine

typealias ItemResponse = AnyPublisher<[RawItem], Error>

protocol ItemService {
    func getItems(forType type: RawItem.ItemType) -> ItemResponse
    func getItems() -> ItemResponse
}

struct RawItem: Decodable {
    enum ItemType: String, Codable {
        case dairy, fruit, vegetable, bakery, vegan, meat
    }

    let title: String
    let description: String
    let type: ItemType
    let price: Double
    let rating: Int
    
    init(item: MockOrder.Item) {
        self.title = item.title
        self.description = item.description
        self.type = item.type
        self.price = item.price
        self.rating = item.rating
    }
}

class OrdersHttpItemService: OrdersHttpClient {
    let mock = MockOrder()

    enum Response {
        struct Payload {
            let items: [RawItem]
        }
    }
}

// MARK: - ItemService

extension OrdersHttpItemService: ItemService {

    func getItems(forType type: RawItem.ItemType) -> ItemResponse {
        mock
            .$items
            .first()
            .map { items -> [RawItem] in
                let filteredItems = items.filter { $0.type == type }
                return filteredItems.map { RawItem(item: $0) }
            }
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func getItems() -> ItemResponse {
        mock
            .$items
            .first()
            .map { $0.map { RawItem(item: $0) } }
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
