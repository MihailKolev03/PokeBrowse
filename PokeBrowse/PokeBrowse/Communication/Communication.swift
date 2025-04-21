//
//  Communication.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import Foundation

protocol GetPokemonListCommunication {
    func getPokemonList(limit: Int, offset: Int) async throws -> PokemonListResponse
}

protocol GetPokemonDetailCommunication {
    func getPokemonDetails(id: Int) async throws -> PokemonDetails
}

protocol GetAllTypesCommunication {
    func getAllTypes() async throws -> TypeListResponse
}

protocol GetPokemonByTypeCommunication {
    func getPokemonByType(url: String) async throws -> TypeDetailResponse
}
