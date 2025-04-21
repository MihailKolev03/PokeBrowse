//
//  TypesCoordinator.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import SwiftUI

class TypesCoordinator: Coordinator, ObservableObject {
    var childCoordinators = [Coordinator]()

    @Published var path = [TypesDestination]()
    @Published var hideTabBar = false

    var initialDestination: TypesDestination

    init() {
        let typesListViewModel = TypesListViewModel()
        initialDestination = .main(viewModel: typesListViewModel)

        typesListViewModel.typeClicked = { [weak self] type in
            self?.showDetails(type: type)
        }
    }

    @ViewBuilder
    func start() -> AnyView {
        AnyView(TypesCoordinatorView(coordinator: self))
    }

    func showDetails(type: NamedAPIResource) {
        hideTabBar = true
        let viewModel = TypeDetailViewModel(type: type)

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
