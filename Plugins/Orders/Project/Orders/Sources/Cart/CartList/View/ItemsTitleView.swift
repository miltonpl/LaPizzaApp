//
//  ItemsTitleView.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 4/30/23.
//

import Designify
import SwiftUI

struct ItemsTitleView: View {
    let title: String
    @State var count: Int
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: DSpace.space16, weight: .medium))
            Spacer()
            Text("\(count) items")
                .font(.system(size: DSpace.space16, weight: .light))
        }
    }
}

struct ItemsTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsTitleView(title: "Items", count: 23)
    }
}
