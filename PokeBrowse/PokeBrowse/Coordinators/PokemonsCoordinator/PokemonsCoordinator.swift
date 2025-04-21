//
//  PokemonsCoordinator.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import SwiftUI

typealias PokemonsCommunication = GetPokemonListCommunication & GetPokemonDetailCommunication

class PokemonsCoordinator: Coordinator, ObservableObject {
    var childCoordinators = [Coordinator]()

    @Published var path = [PokemonsDestination]()
    @Published var hideTabBar = false

    var communication: PokemonsCommunication
    var favoritesManager: FavoritesManager

    var initialDestination: PokemonsDestination

    init(communication: PokemonsCommunication, favoritesManager: FavoritesManager) {
        self.communication = communication
        self.favoritesManager = favoritesManager

        let pokemonListViewModel = PokemonListViewModel(communication: communication, favorites: favoritesManager)
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
        let viewModel = PokemonDetailViewModel(pokemon: pokemon, communication: communication, favorites: favoritesManager)

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

