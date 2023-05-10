//
//  StepperView.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 4/29/23.
//

import SwiftUI

struct StepperView: View {
    @State private(set) var value = 0
    let update: (_ quantity: Int) -> Void

    func incrementStep() {
        value += 1
        update(value)
    }

    func decrementStep() {
        guard value > 0 else { return }
        value -= 1
        update(value)
    }

    var body: some View {
        HStack(alignment: .center) {
            Button {
                decrementStep()
            } label: {
                Image(systemName: "minus")
            }
            Spacer()
            Text("\(value)")
                .bold()
            Spacer()
            Button {
                incrementStep()
            } label: {
                Image(systemName: "plus")
            }
        }.foregroundColor(.black)
            .padding(DSpace.space8)
            .overlay(
                Capsule(style: .continuous)
                    .stroke()
                    .foregroundColor(.gray)
            )
    }
}

struct StepperView_Previews: PreviewProvider {
    static var previews: some View {
        StepperView(update: { quantity in })
    }
}
