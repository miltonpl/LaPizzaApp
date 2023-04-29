//
//  ContentView.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 4/28/23.
//

import SwiftUI

struct ContentView: View {
    enum Constants {
        static let title = "La Pizza"
        static let body = "Order Pizza"
        static let footerTitle = "Palaguachi Inc."
        static let greedings = "Hi"
        static let orderTitle = "Your Order item(s)"
    }

    var orders: [Int] = []

    var body: some View {
        VStack(spacing: 25) {
            OrderHeaderView(
                orders: orders.count,
                title: Constants.title,
                greeding: Constants.greedings
            )
            LogoView()
            .foregroundColor(.white)
            Text(Constants.body)
                .font(.title2)
            OrderTotalView(title: Constants.orderTitle, total: 19.99)
                .padding([.leading, .trailing])
            Spacer()
            Text(Constants.footerTitle)
                .fontWeight(.light)
        }
        .padding([.top, .bottom])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
