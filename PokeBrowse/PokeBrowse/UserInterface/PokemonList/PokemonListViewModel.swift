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

    private let communication: GetPokemonListCommunication
    private let favorites: FavoritesCommunication
    @Published private var favoritePokemons: [Pokemon] = []

    var pokemonClicked: ((Pokemon) -> Void)?

    private(set) var isLoadingMore = false
    private(set) var offset: Int = 0
    private let limit: Int = 40
    private var hasMore = true

    init(communication: GetPokemonListCommunication, favorites: FavoritesCommunication) {
        self.communication = communication
        self.favorites = favorites
    }

    func fetchInitial() {
        pokemons = []
        offset = 0
        hasMore = true
        loadNextPage()
    }

    func loadFavorites() {
        favoritePokemons = favorites.getFavorites()
    }

    func loadNextPage() {
        guard !isLoadingMore, hasMore else { return }

        isLoadingMore = true

        Task {
            do {
                let response = try await communication.getPokemonList(limit: limit, offset: offset)
                let newPokemons = response.results.enumerated().map { index, item in
                    Pokemon(id: offset + index + 1, name: item.name)
                }

                DispatchQueue.main.async {
                    self.pokemons.append(contentsOf: newPokemons)
                    self.offset += self.limit
                    self.hasMore = !newPokemons.isEmpty
                    self.isLoadingMore = false
                }
            } catch {
                print("Error loading Pokémon page: \(error)")
                DispatchQueue.main.async {
                    self.isLoadingMore = false
                }
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

    func isFavorite(_ pokemon: Pokemon) -> Bool {
        favoritePokemons.contains(pokemon)
    }

    func toggleFavorite(_ pokemon: Pokemon) {
        favorites.toggle(pokemon: pokemon)
        loadFavorites()
    }
}
