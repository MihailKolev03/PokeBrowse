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
    }

    @ViewBuilder
    func start() -> AnyView {
        AnyView(TypesCoordinatorView(coordinator: self))
    }

    func removeLastPath() {
        path.removeLast()
        if path.isEmpty {
            hideTabBar = false
        }
    }
}
