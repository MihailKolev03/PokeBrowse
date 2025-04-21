//
//  TypeDetailView.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import SwiftUI

struct TypeDetailView: View {
    let type: NamedAPIResource
    @State private var pokemon: [String] = []

    var body: some View {
        List(pokemon, id: \.self) { name in
            Text(name.capitalized)
        }
        .navigationTitle(type.name.capitalized)
        .onAppear {
            fetchPokemonOfType()
        }
    }

    private func fetchPokemonOfType() {
        guard let url = URL(string: type.url) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(TypeDetailResponse.self, from: data)
                DispatchQueue.main.async {
                    self.pokemon = result.pokemon.map { $0.pokemon.name }
                }
            } catch {
                print("Error decoding type detail: \(error)")
            }
        }.resume()
    }
}

struct TypeDetailResponse: Decodable {
    let pokemon: [PokemonSlot]
}

struct PokemonSlot: Decodable {
    let pokemon: NamedAPIResource
}
