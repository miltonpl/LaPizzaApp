//
//  ItemView.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 4/29/23.
//

import SwiftUI

struct ItemView: View {
    struct Model {
        var quantity: Int
        var title: String
        var description: String
    }

    var model: Model

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: "\(model.quantity).circle")
                .font(.largeTitle)
            VStack(alignment: .leading) {
                Text(model.title)
                Text(model.description)
            }

        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        let model = ItemView.Model(
            quantity: 1,
            title: "Tomatos",
            description: "Jersey Tomators"
        )
        ItemView(model: model)
    }
}
