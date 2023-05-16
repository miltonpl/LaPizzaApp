//
//  Container+Ext.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 5/6/23.
//

import Swinject

extension Container {
    public func get<Service>(_ serviceType: Service.Type = Service.self) -> Service {
        let implementation = resolve(serviceType)
        precondition(implementation != nil, "\(serviceType) has not been register in the container.")
        return implementation!
    }
}

extension Container {
    public func registerWithContainer<Service>(
        _ serviceType: Service.Type,
        factory: @escaping(Container) -> Service
    ) {
        register(serviceType) { _ in
            factory(self)
        }
    }
}

extension Container {
    public func registerWithChildContainer<Service>(
        _ serviceType: Service.Type,
        factory: @escaping(Container) -> Service
    ) {
        register(serviceType) { [weak self] _ in
            factory(Container(parent: self))
        }
    }
}
