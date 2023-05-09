//
//  OliveView.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 5/4/23.
//

import SwiftUI

struct OliveView: View {
    @EnvironmentObject
    var coordinator: FlowCoordinator

    var body: some View {
        List {
            Button("Dismiss") {
                coordinator.dismissfullScreen()
            }
        }
        .navigationTitle("Olive")    }
}

struct OliveView_Previews: PreviewProvider {
    static var previews: some View {
        OliveView()
    }
}
