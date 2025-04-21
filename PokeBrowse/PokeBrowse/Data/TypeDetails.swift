//
//  TypeDetails.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import Foundation

struct TypeDetailResponse: Decodable {
    let pokemon: [PokemonSlot]
}

struct PokemonSlot: Decodable {
    let pokemon: NamedAPIResource
}
