//
//  ButtonView.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 4/30/23.
//

import SwiftUI

struct ButtonView: View {
    enum Style {
        case circular
        case neumorphic
        case neumorphic2
        
        var dropShadow: Color {
            switch self {
                case .circular: return .black
                case .neumorphic: return .dropShadow
                case .neumorphic2: return .white
            }
        }

        var droplight: Color {
            switch self {
                case .circular: return .black
                case .neumorphic: return .dropLight
                case .neumorphic2: return .black
            }
        }

        var fill: Color {
            switch self {
                case .circular: return .black
                case .neumorphic: return .neuBackground
                case .neumorphic2: return .red
            }
        }
    }

    enum Size {
        case xlarge
        case large
        case medium
        case small

        var padding: CGFloat {
            switch self {
                case .xlarge: return 20
                case .large: return 15
                case .medium: return 10
                case .small: return 5
            }
        }
    }

    struct Model {
        let title: String
        let size: Size
        let font: Font
        let color: Color? = nil
    }

    let model: Model
    let style: Style

    let action: () -> Void

    var body: some View {
        switch style {
            case .circular:
                VStack {
                    HStack(alignment: .center) {
                        Button {
                            action()
                        } label: {
                            Text(model.title)
                                .font(model.font)
                        }
                        .padding([.leading, .trailing])
                        .padding(model.size.padding)
                        .foregroundColor(Color.black)
                        .overlay(
                            Capsule(style: .continuous)
                                .stroke(lineWidth: 1)
                                .foregroundColor(.black)
                        )
                    }
                }
            case .neumorphic:
                VStack {
                    Button(model.title, action: action)
                        .padding(model.size.padding)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.neuBackground)
                        )
                        .shadow(color: .dropShadow, radius: 15, x: 10, y: 10)
                        .shadow(color: .dropLight, radius: 15, x: -10, y: -10)
                        .foregroundColor(.primary)
                }

            case .neumorphic2:
                VStack {
                    Button(model.title, action: action)
                        .padding(model.size.padding)
                        .background(
                            ZStack{
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .shadow(color: style.dropShadow, radius: 15, x: -10, y: -10)
                                    .shadow(color: style.dropShadow, radius: 15, x: 10, y: 10)
                                    .blendMode(.overlay)
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(model.color ?? style.fill)
                            }
                        )
                        .foregroundColor(.primary)
                }
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            ButtonView(
                model: .init(
                    title: "Look up items",
                    size: .xlarge, font: .system(
                        size: 20,
                        weight: .semibold
                    )
                ),
                style: .neumorphic,
                action: {}
            )

            ButtonView(
                model: .init(
                    title: "Look up items",
                    size: .xlarge, font: .title
                ),
                style: .neumorphic2,
                action: {}
            )
            ButtonView(
                model: .init(
                    title: "Look up items",
                    size: .medium,
                    font: .title3
                ),
                style: .circular,
                action: {}
            )
        }
//        .background(Color.neuBackground)
        .edgesIgnoringSafeArea(.all)
    }
}
