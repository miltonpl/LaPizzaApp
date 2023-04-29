//
//  LogoView.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 4/28/23.
//

import SwiftUI

struct LogoView: View {
    enum Constats {
        static let image = "pizza_sharing"
        static let text = "unDraw"
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Image(Constats.image)
                .resizable()
                .aspectRatio(3/2, contentMode: .fit)
                .overlay {
                    TextOverlay(text: Constats.text)
                }
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}

struct TextOverlay: View {
    var text: String

    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.3), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center
        )
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading) {
                Text(text)
                    .font(.body)
                    .bold()
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}
