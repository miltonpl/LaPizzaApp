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

public struct RawItem: Decodable {
    public enum ItemType: String, Codable {
        case dairy, fruit, vegetable, bakery, vegan, meat
    }

    let title: String
    let description: String
    let type: ItemType
    let price: Double
    let rating: Int
    
    init(item: MockOrderTemp.Item) {
        self.title = item.title
        self.description = item.description
        self.type = item.type
        self.price = item.price
        self.rating = item.rating
    }
}

class OrdersHttpItemService: OrdersHttpClient {
    let mock = MockOrderTemp()

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
// Temp File
class MockOrderTemp: ObservableObject {
    typealias ItemType = RawItem.ItemType
    struct Item: Decodable {
        let title: String
        let description: String
        let type: ItemType
        let price: Double
        let rating: Int
    }

    @Published
    var items: [Item] = load(from: "items.json")
}

func load<T: Decodable>(from file: String) -> T {
    let data: Data
    guard let fileURL = Bundle.ordersModule.url(forResource: file, withExtension: nil) else {
        fatalError("Couldn't find file `\(file)` in orders bundle.")
        //            return nil
    }
    print(fileURL)
    do {
        data  = try Data(contentsOf: fileURL)
    } catch {
        fatalError("Couldn't load `\(fileURL)` from main bundle\nerror:\(error)")
        //            return nil
    }
    print(data)

    do {
        let decoder = JSONDecoder()
        let items = try decoder.decode(T.self, from: data)
        return items
    } catch {
        fatalError("Couldn't parse \(file) as \(T.self): \nerror: \(error)")
        //            return nil
    }
}
