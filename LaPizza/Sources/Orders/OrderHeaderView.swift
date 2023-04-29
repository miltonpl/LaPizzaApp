//
//  OrderHeaderView.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 4/29/23.
//

import SwiftUI

struct OrderHeaderView: View {
    enum Constants {
        static let cart = "cart"
        static let cartFill = "cart.fill"
    }
    @State var orders: Int
    var title: String
    var greeding: String

    var body: some View {
        HStack(alignment: .center) {
            Text(greeding)
                .font(.title2)
            Spacer()
            Text(title)
                .font(.title)
            Spacer()
            Image(systemName: (orders > 0) ? Constants.cartFill : Constants.cart )
                .resizable()
                .frame(width: 30, height: 30, alignment: .trailing)
            
        }.padding(16)
    }
}

struct OrderHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderHeaderView(orders: 1, title: "Cart", greeding: "Hi")
    }
}
