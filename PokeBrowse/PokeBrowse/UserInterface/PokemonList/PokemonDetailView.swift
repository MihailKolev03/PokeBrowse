//
//  PokemonDetailView.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 20/04/2025.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    @State private var details: PokemonDetails?

    var body: some View {
        VStack {
            if let details = details {
                AsyncImage(url: URL(string: details.imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                } placeholder: {
                    ProgressView()
                }
                Text(details.name.capitalized)
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)

                Text("ID: \(details.id)")
                Text("Height: \(details.height)")
                Text("Weight: \(details.weight)")

                HStack {
                    Text("Types:")
                        .bold()
                    ForEach(details.types, id: \.self) { type in
                        Text(type.capitalized)
                            .padding(6)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(8)
                    }
                }

                Spacer()
            } else {
                ProgressView()
            }
        }
        .padding()
        .onAppear {
            fetchPokemonDetails()
        }
        .navigationTitle(pokemon.name.capitalized)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func fetchPokemonDetails() {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemon.id)")!
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let decoded = try JSONDecoder().decode(PokemonDetails.self, from: data)
                DispatchQueue.main.async {
                    self.details = decoded
                }
            } catch {
                print("Грешка при детайлите: \(error)")
            }
        }.resume()
    }
}

struct PokemonDetails: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [String]

    var imageURL: String {
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }

    private enum CodingKeys: String, CodingKey {
        case id, name, height, weight, typesContainer = "types"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        height = try container.decode(Int.self, forKey: .height)
        weight = try container.decode(Int.self, forKey: .weight)

        let typesArray = try container.decode([TypeSlot].self, forKey: .typesContainer)
        types = typesArray.map { $0.type.name }
    }
}

struct TypeSlot: Codable {
    let slot: Int
    let type: NamedAPIResource
}

struct NamedAPIResource: Codable {
    let name: String
    let url: String
}
