//
//  PreferencesPersistanceAPI.swift
//  Persistance
//
//  Created by Milton Palaguachi on 5/21/23.
//

import Foundation

public protocol PreferenceStoreAPI {
    func saveUserDefaults<Model: PreferenceModel>(_ model: Model?) throws
    func readUserDefaults<Model: PreferenceModel>() throws -> Model?
}

public class PreferenceStoreManager: PreferenceStoreAPI {
    private let userDefaults: UserDefaults
    private let queue = DispatchQueue(label: "com.PreferencesPersistanceManager.queue",
                                      qos: DispatchQoS.userInteractive,
                                      attributes: .concurrent)

    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    public func saveUserDefaults<Model: PreferenceModel>(_ model: Model?) throws {
        let data = try model?.data()

        queue.async(flags: .barrier) { [weak self] in
            guard let data = data else {
                self?.userDefaults.removeObject(forKey: Model.keyIdentifier)
                return
            }
            self?.userDefaults.set(data, forKey: Model.keyIdentifier)
        }
    }

    public func readUserDefaults<Model: PreferenceModel>() throws -> Model? {
        guard let data = queue.sync(execute: { userDefaults.data(forKey: Model.keyIdentifier) }) else {
            return nil
        }

        return try Model.decode(data)
    }
}
