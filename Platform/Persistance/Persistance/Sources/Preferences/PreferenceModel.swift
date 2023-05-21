//
//  PreferenceModel.swift
//  Persistance
//
//  Created by Milton Palaguachi on 5/21/23.
//

import Foundation

public protocol PreferenceModel: Codable {
    static var keyIdentifier: String { get }
}

extension PreferenceModel {
    func data() throws -> Data {
        try JSONEncoder().encode(self)
    }

    static func decode<T: PreferenceModel>(_ data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
}
