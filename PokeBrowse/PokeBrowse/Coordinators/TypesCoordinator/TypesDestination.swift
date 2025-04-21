//
//  TypesDestination.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import SwiftUI

enum TypesDestination {
    case main(viewModel: TypesListViewModel)
    case details(viewModel: TypeDetailViewModel)
}

extension TypesDestination: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(hashValue)
    }

    static func == (lhs: TypesDestination, rhs: TypesDestination) -> Bool {
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

extension TypesDestination: View {
    var body: some View {
        switch self {
        case let .main(viewModel):
            TypesListView(viewModel: viewModel)
        case let .details(viewModel):
            TypeDetailView(viewModel: viewModel)
        }
    }
}
