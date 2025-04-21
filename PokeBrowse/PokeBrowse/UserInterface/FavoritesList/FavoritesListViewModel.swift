//
//  FavoritesListViewModel.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import Foundation

class FavoritesListViewModel: ObservableObject {
    @Published private(set) var favoritePokemons: [Pokemon] = []

    private let favorites: FavoritesCommunication

    var pokemonClicked: ((Pokemon) -> Void)?

    init(favorites: FavoritesCommunication) {
        self.favorites = favorites
        loadFavorites()
    }

    func loadFavorites() {
        favoritePokemons = favorites.getFavorites()
    }

    func isFavorite(_ pokemon: Pokemon) -> Bool {
        favoritePokemons.contains(pokemon)
    }

    func toggleFavorite(_ pokemon: Pokemon) {
        favorites.toggle(pokemon: pokemon)
        loadFavorites()
    }
}
