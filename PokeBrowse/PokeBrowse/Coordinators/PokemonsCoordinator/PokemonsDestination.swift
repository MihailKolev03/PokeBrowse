//
//  PokemonsDestination.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import SwiftUI

enum PokemonsDestination {
    case main(viewModel: PokemonListViewModel)
    case details(viewModel: PokemonDetailViewModel)
}

extension PokemonsDestination: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(hashValue)
    }

    static func == (lhs: PokemonsDestination, rhs: PokemonsDestination) -> Bool {
        switch (lhs, rhs) {
        case let (.main(lhsVM), .main(rhsVM)):
            return lhsVM === rhsVM
        case let (.details(lhsVM), .details(rhsVM)):
            return lhsVM === rhsVM
        default:
            return false
        }
    }
}

extension PokemonsDestination: View {
    var body: some View {
        switch self {
        case let .main(viewModel):
            PokemonListView(viewModel: viewModel)
        case let .details(viewModel):
            PokemonDetailView(viewModel: viewModel)
        }
    }
}
