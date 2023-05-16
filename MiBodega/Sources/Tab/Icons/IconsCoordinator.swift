//
//  FeatureCoordinator.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 5/9/23.
//

import Designify
import Swinject
import SwiftUI

class IconsCoordinator: Coordinator {
    @ViewBuilder
    func build() -> some View {
        NavigationStack {
            designifyAPI.coordinator.build()
            
        }
    }
    
    let designifyAPI: DesignifyPluginAPI
    
    init(container: Container) {
        designifyAPI = container.get()
    }
}
