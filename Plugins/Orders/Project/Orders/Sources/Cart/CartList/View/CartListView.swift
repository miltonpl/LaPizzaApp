//
//  CartListView.swift
//  Orders
//
//  Created by Milton Palaguachi on 4/30/23.
//

import SwiftUI
import Swinject

struct CartListView: View {
    enum ActionType {
        case update(itemId: String, quantity: Int)
    }

    @State
    var data: CartListDataSource.Data
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
                ForEach(data.sections, id: \.id) { section in
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
                total: data.total,
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
