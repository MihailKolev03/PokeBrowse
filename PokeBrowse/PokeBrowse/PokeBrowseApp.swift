//
//  PokeBrowseApp.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 20/04/2025.
//

import SwiftUI

@main
struct PokeBrowseApp: App {
    @StateObject var appCoordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            ZStack {
                appCoordinator.start()
                    .preferredColorScheme(.light)
            }
        }
    }
}
