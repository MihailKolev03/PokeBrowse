//
//  PokemonsDestination.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import SwiftUI

enum PokemonsDestination {
    case main(viewModel: PokemonListViewModel)
    case details
}

extension PokemonsDestination: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(hashValue)
    }

    static func == (lhs: PokemonsDestination, rhs: PokemonsDestination) -> Bool {
        switch (lhs, rhs) {
        case let (.main(lhsVM), .main(rhsVM)):
            return lhsVM === rhsVM
        case (.details, .details):
            return true
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
        case .details:
            Text("Details")
        }
    }
}
