//
//  HomeFooterView.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 4/29/23.
//

import SwiftUI

struct HomeFooterView: View {
    var title: String
    var body: some View {
        Text(title)
            .fontWeight(.light)
    }
}

struct HomeFooterView_Previews: PreviewProvider {
    static var previews: some View {
        HomeFooterView(title: "Palaguachi Inc")
    }
}
