//
//  LemonView.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 5/4/23.
//

import SwiftUI

struct LemonView: View {
    @EnvironmentObject
    var coordinator: FlowCoordinator

    var body: some View {
        List {
            Button("Dismiss") {
                coordinator.dismissSheet()
            }
        }
        .navigationTitle("Lemon")
    }
}

struct LemonView_Previews: PreviewProvider {
    static var previews: some View {
        LemonView()
    }
}
