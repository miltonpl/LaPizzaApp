//
//  FeatureCoordinator.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 5/9/23.
//

import Designify
import Swinject
import SwiftUI

class FeatureCoordinator: Coordinator {
    enum Feature: String, Identifiable {
        case options
        var id: String {
            self.rawValue
        }
    }

    @ViewBuilder
    func build(feature: Feature) -> some View {
        switch feature {
            case .options:
                NavigationStack {
                    designifyAPI.coordinator.build()
                }
        }
    }
    
    let designifyAPI: DesignifyPluginAPI
    
    init(container: Container) {
        designifyAPI = container.get()
    }
}
