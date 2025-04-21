//
//  TypesListViewModel.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import Foundation

class TypesListViewModel: ObservableObject {
    @Published var types: [NamedAPIResource] = []
    var typeClicked: ((NamedAPIResource) -> Void)?

    private let communication: GetAllTypesCommunication

    init(communication: GetAllTypesCommunication) {
        self.communication = communication
    }

    func fetchTypes() {
        Task {
            do {
                let result = try await communication.getAllTypes()
                DispatchQueue.main.async {
                    self.types = result.results
                }
            } catch {
                print("Error loading Pokémon types: \(error)")
            }
        }
    }
}
