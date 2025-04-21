//
//  PokemonListResponse.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import Foundation

struct PokemonListResponse: Codable {
    let results: [PokemonAPIItem]
}

struct PokemonAPIItem: Codable {
    let name: String
    let url: String
}

struct Pokemon: Identifiable, Codable, Equatable {
    let id: Int
    let name: String

    var imageURL: String {
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
}
