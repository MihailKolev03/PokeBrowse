//
//  PokemonsCoordinator.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import SwiftUI

class PokemonsCoordinator: Coordinator, ObservableObject {
    var childCoordinators = [Coordinator]()

    @Published var path = [PokemonsDestination]()
    @Published var hideTabBar = false

    var initialDestination: PokemonsDestination

    init() {
        let pokemonListViewModel = PokemonListViewModel()
        initialDestination = .main(viewModel: pokemonListViewModel)
    }

    @ViewBuilder
    func start() -> AnyView {
        AnyView(PokemonsCoordinatorView(coordinator: self))
    }

    func removeLastPath() {
        path.removeLast()
        if path.isEmpty {
            hideTabBar = false
        }
    }
}

