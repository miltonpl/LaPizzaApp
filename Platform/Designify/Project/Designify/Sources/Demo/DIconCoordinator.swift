//
//  DIconCoordinator.swift
//  Designify
//
//  Created by Milton Palaguachi on 5/11/23.
//

import SwiftUI

public protocol DesignifyPluginAPI {
    var coordinator: DIconCoordinator { get set }
}

public class DesignifyPlugin: DesignifyPluginAPI {
    public var coordinator: DIconCoordinator    

    public init() {
        coordinator = DIconCoordinator()
    }

    public func build() -> some View {
        coordinator.build()
    }
}

public final class DIconCoordinator: ObservableObject {
    @ViewBuilder
    public func build() -> some View {
        DIconView()
    }
}
