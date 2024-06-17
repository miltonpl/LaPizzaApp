//
//  FlowCoordinator.swift
//  LaPizza
//
//  Created by Milton Palaguachi on 5/4/23.
//

import MBPlatform
import SwiftUI

extension FlowCoordinator {
    enum Page: String, Identifiable {
        case apple, banana, carrot
        var id: String{
            self.rawValue
        }
    }
    
    enum Sheet: String, Identifiable {
        case lemon
        var id: String{
            self.rawValue
        }
    }
    
    enum FullScreen: String, Identifiable {
        case olive
        var id: String{
            self.rawValue
        }
    }
}
class FlowCoordinator: Coordinator {
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreen: FullScreen?

    func push(_ page: Page) {
        path.append(page)
    }

    func present(sheet: Sheet) {
        self.sheet = sheet
    }

    func present(fullScreen: FullScreen) {
        self.fullScreen = fullScreen
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }

    func dismissSheet() {
        sheet = nil
    }

    func dismissfullScreen() {
        fullScreen = nil
    }

    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
            case .apple:
                AppleView()
            case .banana:
                BananaView()
            case .carrot:
                CarrotView()
        }
    }

    @ViewBuilder
    func build(sheet: Sheet) -> some View {
        switch sheet {
            case .lemon:
                NavigationStack {
                    LemonView()
                }
        }
    }

    @ViewBuilder
    func build(fullScreen: FullScreen) -> some View {
        switch fullScreen {
            case .olive:
                NavigationStack {
                    OliveView()
                }
        }
    }
}
