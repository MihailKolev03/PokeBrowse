//
//  TypesCoordinatorView.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import SwiftUI

struct TypesCoordinatorView: View {
    @StateObject var coordinator: TypesCoordinator

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.initialDestination
                .navigationDestination(for: TypesDestination.self) { $0 }
                .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar(coordinator.hideTabBar ? .hidden : .visible, for: .tabBar)
        .animation(.linear(duration: 0.5), value: coordinator.hideTabBar)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
