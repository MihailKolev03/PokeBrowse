//
//  TypeDetailViewModel.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import Foundation

class TypeDetailViewModel: ObservableObject {
    @Published var pokemonNames: [String] = []
    @Published var isLoading = true

    let type: NamedAPIResource
    private let communication: GetPokemonByTypeCommunication

    var goBack: Event?

    init(type: NamedAPIResource, communication: GetPokemonByTypeCommunication) {
        self.type = type
        self.communication = communication
    }

    func fetchPokemonOfType() {
        Task {
            do {
                let response = try await communication.getPokemonByType(url: type.url)
                let names = response.pokemon.map { $0.pokemon.name }

                DispatchQueue.main.async {
                    self.pokemonNames = names
                    self.isLoading = false
                }
            } catch {
                print("Error loading Pokémon by type: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }
}
