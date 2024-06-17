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

    @ObservedObject
    var dataSource: CartListDataSource
    @State
    var total: Double = 0.0

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
                        handle(action: .update(itemId: itemId, quantity: quantiy))
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .shadow(color: Color(.systemGray3), radius: 3)
            .ignoresSafeArea()
            CartListFooterView(
                title: .localized(.orderTotalTitle),
                total: $total,
                tapped: {_ in }
            )
            .onAppear(perform: {
//                dump("Total: \(dataSource.data.total)")
                switch dataSource.state {
                    case .success(let total):
                        dump("Total: \(dataSource.data.total)")

                        self.total = total
                    default:
                        break
                }
            })
            .padding([.leading, .trailing])
        }
    }

//    @ViewBuilder
//    func build(state: CartListDataSource.State) -> some View {
//        switch state {
//            case .initial:
//                EmptyView()
//            case .inProgress:
//                ProgressView()
//            case .success(let total):
//                self.total = total
//                EmptyView()
//                
////                CartListView(data: data) { handle(action: $0) }
//            case .failure(let error):
//                Text(error.localizedDescription)
//        }
//    }

    func handle(action: CartListView.ActionType) {
        switch action {
            case .update(let itemId, let quantity):
                if quantity < 1 {
                    dataSource.deleteItem(itemId: itemId)
                } else {
                    dataSource.updateItem(itemId: itemId, quantity: quantity)
                }
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
