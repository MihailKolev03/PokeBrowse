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
                print("\(error.localizedDescription)")
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
