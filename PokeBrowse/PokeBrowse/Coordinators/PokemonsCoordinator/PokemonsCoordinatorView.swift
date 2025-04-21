//
//  PokemonsCoordinatorView.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import SwiftUI

struct PokemonsCoordinatorView: View {
    @StateObject var coordinator: PokemonsCoordinator

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.initialDestination
                .navigationDestination(for: PokemonsDestination.self) { $0 }
                .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar(coordinator.hideTabBar ? .hidden : .visible, for: .tabBar)
        .animation(.linear(duration: 0.5), value: coordinator.hideTabBar)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
