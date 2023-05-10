//
//  CartListSectionView.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 4/30/23.
//

import SwiftUI

struct CartListSectionView: View {
    let section: CartListDataSource.Data.Section
    let update: (_ quantiy: Int, _ itemId: String) -> Void

    var body: some View {
        Section() {
            ItemsTitleView(title: section.title, count: section.items.count)
            ForEach(section.items, id: \.self) {
                ItemView(model: .init(rawItem: $0), update: update)
                    .buttonStyle(PlainButtonStyle())
                    .listRowInsets(.init(uniformInset: DSpace.space8))
            }
        }.headerProminence(.increased)
    }
}

struct CartListSectionView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            CartListSectionView(
                section: .init(
                    title: "items",
                    itemType: .fruit,
                    items:
                        [.init(title: "Karot", type: .vegetable, quantity: 1, description: "ss", price: 32.99, rating: 3),
                         .init(title: "Karot", type: .vegetable, quantity: 1, description: "ss", price: 32.99, rating: 3),
                         .init(title: "Karot", type: .vegetable, quantity: 1, description: "ss", price: 32.99, rating: 3),
                         
                        ]
                ),
                update: { _, _ in }
            )
        }
        .shadow(color: .red, radius: 25, x: 0, y: 0)
        .background(.white).ignoresSafeArea()
    }
}
