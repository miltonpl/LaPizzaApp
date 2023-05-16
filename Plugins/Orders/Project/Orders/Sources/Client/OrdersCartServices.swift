//
//  CartServices.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 5/6/23.
//

import Combine
import Foundation

typealias CartResponse = (RawCart, [RawItem])

struct RawCart {
    enum State {
        case created, suspended
    }

    let id: String
    let state: State
    let date: Date
}

protocol CartService {
     func createdCart() -> AnyPublisher<CartResponse, Error>
}

class OrdersHttpCartService: OrdersHttpClient {
    enum Response {
        struct Payload {
            
        }
    }

     func createdCart() -> AnyPublisher<CartResponse, Error> {
         if #available(iOS 15, *) {
             return Just((RawCart(id: UUID().uuidString, state: .created, date: .now),[]))
                 .setFailureType(to: Error.self).eraseToAnyPublisher()
         } else {
             // Fallback on earlier versions
             return Just((RawCart(id: UUID().uuidString, state: .created, date: Date()),[]))
                 .setFailureType(to: Error.self).eraseToAnyPublisher()
         }
     }
}
extension OrdersHttpCartService: CartService { }
