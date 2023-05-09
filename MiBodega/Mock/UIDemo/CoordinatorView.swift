//
//  CoordinatorView.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 5/3/23.
//

import SwiftUI
import Combine
import Swinject

struct CoordinatorView: View {
    @ObservedObject
    var coordinator =  FlowCoordinator()
    let container: Container

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .apple)
                .navigationDestination(for: FlowCoordinator.Page.self) { page in
                    coordinator.build(page: page)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.build(sheet: sheet)
                }
                .fullScreenCover(item: $coordinator.fullScreen) { fullScreen in
                    coordinator.build(fullScreen: fullScreen)
                }
        }
        .environmentObject(coordinator)
    }
}

struct CoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatorView(container: Container())
    }
}
