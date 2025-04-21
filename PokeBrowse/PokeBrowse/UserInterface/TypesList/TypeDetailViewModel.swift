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

    var goBack: Event?

    init(type: NamedAPIResource) {
        self.type = type
    }

    func fetchPokemonOfType() {
        guard let url = URL(string: type.url) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                self.isLoading = false
            }

            guard let data = data else { return }

            do {
                let result = try JSONDecoder().decode(TypeDetailResponse.self, from: data)
                DispatchQueue.main.async {
                    self.pokemonNames = result.pokemon.map { $0.pokemon.name }
                }
            } catch {
                print("Error decoding type detail: \(error)")
            }
        }.resume()
    }
}
