//
//  AppleView.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 5/4/23.
//

import SwiftUI

struct AppleView: View {
    @EnvironmentObject
    var coordinator: FlowCoordinator

    var body: some View {
        List {
            Button("Push Banana") {
                coordinator.push(.banana)
            }
            Button("Present Lemon") {
                coordinator.present(sheet: .lemon)
            }
            Button("Present Olive") {
                coordinator.present(fullScreen: .olive)
            }
        }.navigationTitle("Apple")
    }
}

struct AppleView_Previews: PreviewProvider {
    static var previews: some View {
        AppleView()
    }
}
