//
//  FavoritesDestination.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import SwiftUI

enum FavoritesDestination {
    case main(viewModel: FavoritesListViewModel)
}

extension FavoritesDestination: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(hashValue)
    }

    static func == (lhs: FavoritesDestination, rhs: FavoritesDestination) -> Bool {
        switch (lhs, rhs) {
        case let (.main(lhsVM), .main(rhsVM)):
            return lhsVM === rhsVM
        }
    }
}

extension FavoritesDestination: View {
    var body: some View {
        switch self {
        case let .main(viewModel):
            FavoritesListView(viewModel: viewModel)
        }
    }
}
