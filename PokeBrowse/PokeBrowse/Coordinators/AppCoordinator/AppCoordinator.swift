//
//  AppCoordinator.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import Combine
import SwiftUI

typealias Event = () -> Void
typealias Communication = GetPokemonListCommunication & GetPokemonDetailCommunication & GetAllTypesCommunication & GetPokemonByTypeCommunication

class AppCoordinator: Coordinator, ObservableObject {
    var childCoordinators = [Coordinator]()
    var communicationManager: Communication

    @Published var appState: AppDestination

    @MainActor
    init() {
        appState = .loading
        communicationManager = CommunicationManager()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }

            self.startMainAppFlow()
        }
    }

    func start() -> AnyView {
        AnyView(AppCoordinatorView(coordinator: self))
    }

    private func startMainAppFlow() {
        let tabBarCoordinator = TabBarCoordinator(communicationManager: communicationManager)
        appState = .tabBar(tabBarCoordinator)
    }

    private func handleLoginSuccess() {
        startMainAppFlow()
    }
}
