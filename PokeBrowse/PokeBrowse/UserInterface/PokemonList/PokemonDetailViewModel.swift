//
//  PokemonDetailViewModel.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import Foundation

class PokemonDetailViewModel: ObservableObject {
    @Published var details: PokemonDetails?
    @Published var isLoading = true

    let pokemon: Pokemon
    private let communication: GetPokemonDetailCommunication

    var goBack: Event?

    init(pokemon: Pokemon, communication: GetPokemonDetailCommunication) {
        self.pokemon = pokemon
        self.communication = communication
    }

    func fetchDetails() {
        Task {
            do {
                let data = try await communication.getPokemonDetails(id: pokemon.id)
                DispatchQueue.main.async {
                    self.details = data
                    self.isLoading = false
                }
            } catch {
                print("Error loading Pokémon details: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }
}
