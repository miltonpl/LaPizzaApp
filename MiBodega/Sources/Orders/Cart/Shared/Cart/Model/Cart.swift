//
//  Cart.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 5/6/23.
//

import Foundation

struct Cart: Identifiable {
    struct Item: Hashable {
        enum ItemType: String, Codable {
            case dairy, fruit, vegetable, bakery, vegan, meat
            init(type: RawItem.ItemType)  {
                switch type {
                    case .dairy:
                        self = .dairy
                    case .fruit:
                        self = .fruit
                    case .vegetable:
                        self = .vegetable
                    case .bakery:
                        self = .bakery
                    case .vegan:
                        self = .vegan
                    case .meat:
                        self = .meat
                }
            }
        }

        let title: String
        let type: ItemType
        var quantity: Int
        let description: String
        let price: Double
        let total: Double
        let rating: Int
        let id: String

        init(raw: RawItem) {
            self.title = raw.title
            self.type = .init(type: raw.type)
            self.quantity = 1
            self.description = raw.description
            self.price = raw.price
            self.total = raw.price
            self.rating = raw.rating
            self.id = UUID().uuidString
        }

        init(title: String,
             type: ItemType,
             quantity: Int,
             description: String,
             price: Double,
             rating: Int,
             id: String = UUID().uuidString
             
        ) {
            self.title = title
            self.type = type
            self.quantity = quantity
            self.description = description
            self.price = price
            self.total = price * Double(quantity)
            self.rating = rating
            self.id = id
        }
    }
    
    let id: String
    let created: Date
    let items: [Item]
}

enum CartState {
    case created
    case checkout
}
