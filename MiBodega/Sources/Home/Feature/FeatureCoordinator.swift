//
//  FeatureCoordinator.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 5/9/23.
//

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
                    FeatureView() { result in
                        print("action \(result)")
                    }
                }
        }
    }
    
    init(container: Container) {}
    
}
