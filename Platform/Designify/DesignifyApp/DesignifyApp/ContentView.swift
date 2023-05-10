//
//  ContentView.swift
//  DesignifyApp
//
//  Created by Milton Palaguachi on 5/9/23.
//

import SwiftUI
import Designify


struct ContentView: View {
    var body: some View {
        VStack {
            DIcon.cart.image
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!\(DSpace.space10)")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
