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
        pokemonListViewModel.pokemonClicked = { [weak self] pokemon in
            self?.showDetails(pokemon: pokemon)
        }
    }

    @ViewBuilder
    func start() -> AnyView {
        AnyView(PokemonsCoordinatorView(coordinator: self))
    }

    func showDetails(pokemon: Pokemon) {
        hideTabBar = true
        let viewModel = PokemonDetailViewModel(pokemon: pokemon)

        viewModel.goBack = { [weak self] in
            self?.removeLastPath()
        }

        path.append(.details(viewModel: viewModel))
    }

    func removeLastPath() {
        path.removeLast()
        if path.isEmpty {
            hideTabBar = false
        }
    }
}

