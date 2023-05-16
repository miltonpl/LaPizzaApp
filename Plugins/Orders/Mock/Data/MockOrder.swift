//
//  MockOrder.swift
//  Orders
//
//  Created by Milton Palaguachi on 4/29/23.
//

import Foundation
import Combine

class MockOrder: ObservableObject {
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
