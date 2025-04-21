//
//  FavoritesManager.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import Foundation

class FavoritesManager: FavoritesCommunication, ObservableObject {
    @Published private var favorites: [Pokemon] = []
    private let key = "favorite_pokemon_list"

    init() {
        load()
    }

    func toggle(pokemon: Pokemon) {
        if let index = favorites.firstIndex(of: pokemon) {
            favorites.remove(at: index)
        } else {
            favorites.append(pokemon)
        }
        save()
    }

    func isFavorite(_ pokemon: Pokemon) -> Bool {
        favorites.contains(pokemon)
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([Pokemon].self, from: data) {
            self.favorites = decoded
        }
    }

    private func save() {
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    func getFavorites() -> [Pokemon] {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([Pokemon].self, from: data) {
            return decoded
        }
        return []
    }
}

protocol FavoritesCommunication {
    func toggle(pokemon: Pokemon)
    func isFavorite(_ pokemon: Pokemon) -> Bool
    func getFavorites() -> [Pokemon]
}
