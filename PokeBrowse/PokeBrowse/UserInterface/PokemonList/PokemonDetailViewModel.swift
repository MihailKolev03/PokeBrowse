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

    var goBack: Event?

    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }

    func fetchDetails() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemon.id)") else {
            print("Невалиден URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            guard let data = data, error == nil else {
                print("Грешка при заявката: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let decoded = try JSONDecoder().decode(PokemonDetails.self, from: data)
                DispatchQueue.main.async {
                    self.details = decoded
                }
            } catch {
                print("Грешка при декодиране: \(error)")
            }
        }.resume()
    }
}
