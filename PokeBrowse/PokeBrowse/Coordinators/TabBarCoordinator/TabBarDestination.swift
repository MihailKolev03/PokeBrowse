//
//  TabBarDestination.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import SwiftUI

enum TabBarDestination: Identifiable {
    var id: String {
        switch self {
        case .pokemonList:
            "pokemonList"
        case .types:
            "types"
        case .favorites:
            "favorites"
        }
    }
    
    case pokemonList(PokemonsCoordinator)
    case types(TypesCoordinator)
    case favorites(FavoritesCoordinator)
    
    var icon: String {
        switch self {
        case .pokemonList:
            return "list.clipboard"
        case .types:
            return "square.stack.3d.up"
        case .favorites:
            return "heart"
        }
    }

    var iconSelected: String {
        switch self {
        case .pokemonList:
            return "list.clipboard.fill"
        case .types:
            return "square.stack.3d.up.fill"
        case .favorites:
            return "heart.fill"
        }
    }
    
    var title: String {
        switch self {
        case .pokemonList:
            return "Pokemons"
        case .types:
            return "Types"
        case .favorites:
            return "Favorites"
        }
    }
}

extension TabBarDestination: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(hashValue)
    }

    static func == (lhsCoord: TabBarDestination, rhs: TabBarDestination) -> Bool {
        switch (lhsCoord, rhs) {
        case let (.pokemonList(lhsCoord), .pokemonList(rhsCoord)):
            return lhsCoord === rhsCoord
        case let (.types(lhsCoord), .types(rhsCoord)):
            return lhsCoord === rhsCoord
        case let (.favorites(lhsCoord), .favorites(rhsCoord)):
            return lhsCoord === rhsCoord
        default:
            assertionFailure("Unhandled case in TabBarDestination equality")
            return false
        }
    }
}

extension TabBarDestination: View {
    var body: some View {
        switch self {
        case let .pokemonList(coordinator):
            coordinator.start()
        case let .types(coordinator):
            coordinator.start()
        case let .favorites(coordinator):
            coordinator.start()
        }
    }
}
