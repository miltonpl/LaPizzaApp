//
//  CarrotView.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 5/4/23.
//

import SwiftUI

struct CarrotView: View {
    @EnvironmentObject
    var coordinator: FlowCoordinator

    var body: some View {
        List {
            Button("Pop") {
                coordinator.pop()
            }
            Button("Pop to root") {
                coordinator.popToRoot()
            }
        }
    }
}

struct CarrotView_Previews: PreviewProvider {
    static var previews: some View {
        CarrotView()
    }
}
