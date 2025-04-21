//
//  PokemonDetails.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import Foundation

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
