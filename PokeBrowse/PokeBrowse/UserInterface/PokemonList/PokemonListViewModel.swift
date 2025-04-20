//
//  PokemonListViewModel.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 20/04/2025.
//

import Foundation

struct Pokemon: Identifiable, Codable {
    let id: Int
    let name: String

    var imageURL: String {
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
}

class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []

    func fetchPokemon() {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=100")!
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                DispatchQueue.main.async {
                    self.pokemons = result.results.enumerated().map { (index, item) in
                        Pokemon(id: index + 1, name: item.name)
                    }
                }
            } catch {
                print("Грешка при декодиране: \(error)")
            }
        }.resume()
    }

    func filteredPokemon(searchText: String) -> [Pokemon] {
        if searchText.isEmpty { return pokemons }
        return pokemons.filter {
            $0.name.lowercased().contains(searchText.lowercased()) ||
            "\($0.id)" == searchText
        }
    }
}

struct PokemonListResponse: Codable {
    let results: [PokemonAPIItem]
}

struct PokemonAPIItem: Codable {
    let name: String
    let url: String
}
