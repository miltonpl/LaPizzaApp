//
//  DIconCoordinator.swift
//  Designify
//
//  Created by Milton Palaguachi on 5/11/23.
//

import SwiftUI
import Swinject

public protocol DesignifyPluginAPI {
    var coordinator: DIconCoordinator { get set }
}

public class DesignifyPlugin: DesignifyPluginAPI {
    public var coordinator: DIconCoordinator    
    let container: Container

    public init(container: Container) {
        self.container = container
        coordinator = DIconCoordinator(container: container)
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

    init(container: Container) {}
}
