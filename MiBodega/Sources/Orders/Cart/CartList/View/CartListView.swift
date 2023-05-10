//
//  CartListView.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 4/30/23.
//

import SwiftUI
import Swinject

struct CartListView: View {
    typealias Section = CartListDataSource.Data.Section
    enum ActionType {
        case update(itemId: String, quantity: Int)
    }

    struct Model {
        var sections: [Section]
        var total: Double
    }

    @ObservedObject
    var dataSource: CartListDataSource
    var action: ((ActionType) -> Void)?

    var body: some View {
        VStack {
            ButtonView(
                model: .init(
                    title: "Hello",
                    size: .medium, font: .subheadline
                ),
                style: .circular
            ) {

            }
            List {
                ForEach(dataSource.data.sections, id: \.id) { section in
                    CartListSectionView(section: section) { quantiy, itemId in
                            action?(.update(itemId: itemId, quantity: quantiy))
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .shadow(color: Color(.systemGray3), radius: 3)
            .ignoresSafeArea()
            CartListFooterView(
                title: .localized(.orderTotalTitle),
                total: dataSource.data.total,
                tapped: {_ in }
            )
            .padding([.leading, .trailing])
        }
    }
}

//struct CartListView_Previews: PreviewProvider {
//    @State var model: CartListView.Model = .init(sections: [], total: 0.0)
//
//    static var previews: some View {
//        CartListView(model: $model, action: {_ in })
//    }
//}
