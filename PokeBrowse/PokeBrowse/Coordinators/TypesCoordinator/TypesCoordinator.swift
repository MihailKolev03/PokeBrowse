//
//  TypesCoordinator.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import SwiftUI

typealias TypesCommunication = GetAllTypesCommunication & GetPokemonByTypeCommunication

class TypesCoordinator: Coordinator, ObservableObject {
    var childCoordinators = [Coordinator]()

    @Published var path = [TypesDestination]()
    @Published var hideTabBar = false

    var communication: TypesCommunication

    var initialDestination: TypesDestination

    init(communication: TypesCommunication) {
        self.communication = communication
        let typesListViewModel = TypesListViewModel(communication: communication)
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
        let viewModel = TypeDetailViewModel(type: type, communication: communication)

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
