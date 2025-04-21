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
    let baseExperience: Int
    let types: [String]
    let abilities: [String]
    let stats: [PokemonStat]

    var imageURL: String {
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }

    private enum CodingKeys: String, CodingKey {
        case id, name, height, weight, baseExperience = "base_experience"
        case typesContainer = "types"
        case abilitiesContainer = "abilities"
        case statsContainer = "stats"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        height = try container.decode(Int.self, forKey: .height)
        weight = try container.decode(Int.self, forKey: .weight)
        baseExperience = try container.decode(Int.self, forKey: .baseExperience)

        let typesArray = try container.decode([TypeSlot].self, forKey: .typesContainer)
        types = typesArray.map { $0.type.name }

        let abilityArray = try container.decode([AbilitySlot].self, forKey: .abilitiesContainer)
        abilities = abilityArray.map { $0.ability.name }

        let statArray = try container.decode([StatSlot].self, forKey: .statsContainer)
        stats = statArray.map { PokemonStat(name: $0.stat.name, baseValue: $0.baseStat) }
    }
}

struct TypeSlot: Codable {
    let slot: Int
    let type: NamedAPIResource
}

struct AbilitySlot: Codable {
    let ability: NamedAPIResource
    let isHidden: Bool?

    private enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
    }
}

struct StatSlot: Codable {
    let baseStat: Int
    let stat: NamedAPIResource

    private enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

struct PokemonStat: Identifiable {
    let id = UUID()
    let name: String
    let baseValue: Int
}

struct NamedAPIResource: Codable {
    let name: String
    let url: String
}
