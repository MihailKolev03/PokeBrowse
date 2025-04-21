//
//  PokemonListViewModel.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 20/04/2025.
//

import Foundation

class PokemonListViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var pokemons: [Pokemon] = []

    var pokemonClicked: ((Pokemon) -> Void)?
    private let communication: GetPokemonListCommunication

    init(communication: GetPokemonListCommunication) {
        self.communication = communication
    }

    func fetchPokemon(limit: Int = 100, offset: Int = 0) {
        Task {
            do {
                let response = try await communication.getPokemonList(limit: limit, offset: offset)
                let mapped = response.results.enumerated().map { index, item in
                    Pokemon(id: index + 1 + offset, name: item.name)
                }

                DispatchQueue.main.async {
                    self.pokemons = mapped
                }
            } catch {
                print("Error fetching Pokémon list: \(error)")
            }
        }
    }

    func filteredPokemon(searchText: String) -> [Pokemon] {
        if searchText.isEmpty { return pokemons }
        return pokemons.filter {
            $0.name.lowercased().contains(searchText.lowercased()) ||
            "\($0.id)" == searchText
        }
    }
}
