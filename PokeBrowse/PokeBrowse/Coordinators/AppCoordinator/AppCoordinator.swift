//
//  AppCoordinator.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import Combine
import SwiftUI

typealias Event = () -> Void

class AppCoordinator: Coordinator, ObservableObject {
    var childCoordinators = [Coordinator]()

    @Published var appState: AppDestination

    @MainActor
    init() {
        appState = .loading

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }

            self.startMainAppFlow()
        }
    }

    func start() -> AnyView {
        AnyView(AppCoordinatorView(coordinator: self))
    }

    private func startMainAppFlow() {
        let tabBarCoordinator = TabBarCoordinator()
        appState = .tabBar(tabBarCoordinator)
    }

    private func handleLoginSuccess() {
        startMainAppFlow()
    }
}
