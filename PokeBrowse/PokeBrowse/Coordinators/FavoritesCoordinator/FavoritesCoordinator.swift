//
//  FavoritesCoordinator.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import SwiftUI

class FavoritesCoordinator: Coordinator, ObservableObject {
    var childCoordinators = [Coordinator]()

    @Published var path = [FavoritesDestination]()
    @Published var hideTabBar = false

    var favoritesManager: FavoritesManager

    var initialDestination: FavoritesDestination

    init(favoritesManager: FavoritesManager) {
        self.favoritesManager = favoritesManager

        let favoritesListViewModel = FavoritesListViewModel(favorites: favoritesManager)
        initialDestination = .main(viewModel: favoritesListViewModel)
    }

    @ViewBuilder
    func start() -> AnyView {
        AnyView(FavoritesCoordinatorView(coordinator: self))
    }
}

