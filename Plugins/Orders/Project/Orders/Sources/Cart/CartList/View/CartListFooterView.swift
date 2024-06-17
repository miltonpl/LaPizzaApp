//
//  CartListFooterView.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 4/29/23.
//

import Designify
import SwiftUI

struct CartListFooterView: View {
    enum Constant {
        static let image =  "barcode.viewfinder"
        static let scanButtonTitle = "Scan items"
        static let checkoutButtonTitle = "Check out"
    }

    enum ButtonType {
        case scan, checkout
    }

    var title: String
    @Binding var total: Double
    let tapped: (ButtonType) -> Void

    var body: some View {
        VStack(spacing: DSpace.space16) {
            HStack(alignment: .firstTextBaseline,
                   spacing: DSpace.space8) {
                Spacer()
                Text(title)
                    .font(.system(size: DSpace.space16, weight: .semibold))
                Text(total, format: .currency(code: "USD"))
                    .font(.system(size: DSpace.space16, weight: .semibold))
            }
            HStack(alignment: .center) {
                Button {
                    tapped(.scan)
                } label: {
                    HStack {
                        Image(systemName: Constant.image)
                        Text(Constant.scanButtonTitle)
                            .font(.system(size: DSpace.space16, weight: .semibold))
                    }
                }
                .frame(
                    width: DSpace.space36*4, height: DSpace.space32
                )
                .foregroundColor(Color.black)
                .overlay(
                    Capsule(style: .continuous)
                        .stroke()
                        .foregroundColor(.black)
                )
                Spacer()
                Button {
                    tapped(.checkout)
                } label: {
                    Text(Constant.checkoutButtonTitle)
                        .font(.system(size: DSpace.space16, weight: .semibold))
                        .frame(
                            width: DSpace.space36*4, height: DSpace.space32
                        )
                        .foregroundColor(Color.white)
                        .background(.red)
                        .clipShape(
                            Capsule(style: .continuous)
                        )
                }
                
            }.padding([.bottom])
        }
    }
}

//struct CartListFooterView_Previews: PreviewProvider {
//    static var previews: some View {
//        CartListFooterView(
//            title: "Your Oders items",
//            total: 19.99,
//            tapped: { _ in }
//        )
//            .padding()
//    }
//}
