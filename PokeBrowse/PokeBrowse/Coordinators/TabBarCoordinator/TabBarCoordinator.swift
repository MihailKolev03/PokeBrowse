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

    private lazy var pokemonsCoordinator: PokemonsCoordinator = {
        let coordinator = PokemonsCoordinator(communication: communicationManager)
        return coordinator
    }()
    
    private lazy var typesCoordinator: TypesCoordinator = {
        let coordinator = TypesCoordinator(communication: communicationManager)
        return coordinator
    }()

    init(communicationManager: Communication) {
        self.communicationManager = communicationManager
        let pokemons = TabBarDestination.pokemonList(pokemonsCoordinator)
        let types = TabBarDestination.types(typesCoordinator)
        destinations = [pokemons, types]
    }

    @ViewBuilder
    func start() -> AnyView {
        AnyView(TabBarCoordinatorView(coordinator: self))
    }
}
