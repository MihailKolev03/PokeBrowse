//
//  TypesListViewModel.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import Foundation

class TypesListViewModel: ObservableObject {
    @Published var types: [NamedAPIResource] = []

    func fetchTypes() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/type/") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(TypeListResponse.self, from: data)
                DispatchQueue.main.async {
                    self.types = result.results
                }
            } catch {
                print("Error decoding types: \(error)")
            }
        }.resume()
    }
}

struct TypeListResponse: Decodable {
    let results: [NamedAPIResource]
}
