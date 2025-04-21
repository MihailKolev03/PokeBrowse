//
//  PokemonDetailViewModel.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import Foundation
import Combine

class PokemonDetailViewModel: ObservableObject {
    @Published var details: PokemonDetails?
    @Published var isLoading = true

    let pokemon: Pokemon
    private let communication: GetPokemonDetailCommunication
    private let favorites: FavoritesCommunication

    @Published var isFavorite: Bool

    var goBack: Event?

    init(pokemon: Pokemon, communication: GetPokemonDetailCommunication, favorites: FavoritesCommunication) {
        self.pokemon = pokemon
        self.communication = communication
        self.favorites = favorites

        self.isFavorite = favorites.isFavorite(pokemon)
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

    func toggleFavorite() {
        favorites.toggle(pokemon: pokemon)
        isFavorite.toggle()
    }
}
