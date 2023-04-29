//
//  OrderTotalView.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 4/29/23.
//

import SwiftUI

struct OrderTotalView: View {
    var title: String
    @State var total: Double
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
            Spacer()
            Text(total, format: .currency(code: "USD"))
        }
    }
}

struct OrderTotalView_Previews: PreviewProvider {
    static var previews: some View {
        OrderTotalView(title: "Your Oders items", total: 19.99)
            .padding()
    }
}
