//
//  BananaView.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 5/4/23.
//

import SwiftUI

struct BananaView: View {
    @EnvironmentObject
    var coordinator: FlowCoordinator

    var body: some View {
        List {
            Button("Push Carrot") {
                coordinator.push(.carrot)
            }
            Button("Pop") {
                coordinator.pop()
            }
        }
        .navigationTitle("Banana")
    }
}

struct BananaView_Previews: PreviewProvider {
    static var previews: some View {
        BananaView()
    }
}
