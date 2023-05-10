//
//  FeatureView.swift
//  MiBodega
//
//  Created by Milton Palaguachi on 5/3/23.
//

import SwiftUI

struct FeatureView: View {
    enum ActionType {
        case first, second, third, fourth
    }

    let actionType: (ActionType) -> Void

    var body: some View {
        VStack(alignment: .center, spacing: DSpace.space16) {
            HStack(alignment: .center, spacing: DSpace.space16){
                ButtonView(
                    model: .init(title: "First Action", size: .large, font: .callout),
                    style: .neumorphic) {
                        actionType(.first)
                    }
                ButtonView(
                    model: .init(title: "Second Action", size: .large, font: .callout),
                    style: .neumorphic) {
                        actionType(.second)
                    }
            }
            
            HStack(alignment: .center, spacing: DSpace.space16) {
                ButtonView(
                    model: .init(title: "Third Action", size: .large, font: .callout),
                    style: .neumorphic) {
                        actionType(.third)
                    }
                ButtonView(
                    model: .init(title: "Fourth Action", size: .large, font: .callout),
                    style: .neumorphic) {
                        actionType(.fourth)
                    }
            }
        }
    }
}

#if DEDUB
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureView(actionType: { result in
            dump(result)
        })
    }
}
#endif
