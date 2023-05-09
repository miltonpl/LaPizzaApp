//
//  MiBodegaApp.swift
//  MiBodega
//
//  Created by Milton Palaguachi on 4/28/23.
//

import SwiftUI

@main
struct MiBodegaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            HomeContainerView(
                coordinator: .init(container: appDelegate.container)
            )
        }
    }
}
