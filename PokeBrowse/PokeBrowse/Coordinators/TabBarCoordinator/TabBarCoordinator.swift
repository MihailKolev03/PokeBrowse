//
//  TabBarCoordinator.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import SwiftUI

class TabBarCoordinator: Coordinator, ObservableObject {
    var childCoordinators = [Coordinator]()

    @Published var selectedDestination: Int = 0
    @Published var destinations: [TabBarDestination] = []

    var communicationManager: Communication
    var favoritesManager: FavoritesManager

    private lazy var pokemonsCoordinator: PokemonsCoordinator = {
        let coordinator = PokemonsCoordinator(communication: communicationManager, favoritesManager: favoritesManager)
        return coordinator
    }()
    
    private lazy var typesCoordinator: TypesCoordinator = {
        let coordinator = TypesCoordinator(communication: communicationManager)
        return coordinator
    }()

    private lazy var favoritesCoordinator: FavoritesCoordinator = {
        let coordinator = FavoritesCoordinator(favoritesManager: favoritesManager)
        return coordinator
    }()

    init(communicationManager: Communication, favoritesManager: FavoritesManager) {
        self.communicationManager = communicationManager
        self.favoritesManager = favoritesManager
        let pokemons = TabBarDestination.pokemonList(pokemonsCoordinator)
        let types = TabBarDestination.types(typesCoordinator)
        let favorites = TabBarDestination.favorites(favoritesCoordinator)
        destinations = [pokemons, types, favorites]
    }

    @ViewBuilder
    func start() -> AnyView {
        AnyView(TabBarCoordinatorView(coordinator: self))
    }
}
