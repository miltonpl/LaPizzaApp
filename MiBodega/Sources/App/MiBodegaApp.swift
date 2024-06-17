//
//  MiBodegaApp.swift
//  MiBodega
//
//  Created by Milton Palaguachi on 4/28/23.
//

import SwiftUI
import HubCenter

@main
struct MiBodegaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var navigationPath = NavigationPath()

    var body: some Scene {
        WindowGroup {
            MainTabContainerView(
                navigationPath: $navigationPath,
                coordinator: .init(container: appDelegate.container)
            )
        }
    }
}
