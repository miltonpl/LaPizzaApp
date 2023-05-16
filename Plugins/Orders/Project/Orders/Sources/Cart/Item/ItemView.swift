//
//  ItemView.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 4/29/23.
//

import Foundation
import Designify
import SwiftUI

struct ItemView: View {
    enum Constant {
        static let textLineNumber2 = 2
        static let textLineNumber1 = 1
        static let stepperCorner = 25.0
    }
    struct Model: Hashable {
        var quantity: Int
        var title: String
        var total: Double
        var description: String
        var rating: Int
        var id: String
    }

    let model: Model
    let update: (_ quantiy: Int, _ itemId: String) -> Void

    var body: some View {
        HStack(alignment: .top, spacing: DSpace.space16) {
            Image(systemName: "\(model.quantity).circle")
                .font(.largeTitle)
            VStack(alignment: .leading) {
                HStack {
                    Text(model.title)
                    Spacer()
                    Text(model.total, format: .currency(code: "USD"))
                }
                HStack {
                    Text(model.description)
                        .lineLimit(Constant.textLineNumber2)
                }
                HStack(spacing: DSpace.space16) {
                    Text("Rating \(model.rating)")
                        .lineLimit(Constant.textLineNumber1)
                    Spacer()
                    StepperView(value: model.quantity, update: { update($0, model.id)})
                        .frame(width: 150, height: 40)
                        .cornerRadius(Constant.stepperCorner)
                }
            }
        }
    }
}

extension ItemView.Model {
    init(rawItem: Cart.Item) {
        self.init(
            quantity: rawItem.quantity,
            title: rawItem.title,
            total: rawItem.total,
            description: rawItem.description,
            rating: rawItem.rating,
            id: rawItem.id
        )
    }
}
    
struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        let model = ItemView.Model(
            quantity: 1,
            title: "Tomatos",
            total: 23.99,
            description: "Jersey Tomators",
            rating: 1,
            id: UUID().uuidString
        )
        ItemView(model: model, update: { _, _ in })
    }
}
