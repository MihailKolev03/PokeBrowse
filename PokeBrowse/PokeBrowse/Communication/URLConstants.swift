//
//  URLConstants.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import Foundation
import Alamofire

protocol URLConvertible {
    var url: String { get }
}

protocol HTTPMethodConvertible {
    var method: HTTPMethod { get }
}

struct Constants { }

extension Constants {
    enum RequestEndpoint {
        case getPokemonList(limit: Int, offset: Int)
        case getPokemonDetails(id: Int)
        case getAllTypes
        case getPokemonByType(url: String)

        static let baseURL = "https://pokeapi.co/api/v2"
    }
}

extension Constants.RequestEndpoint: URLConvertible {
    var url: String {
        switch self {
        case .getPokemonList(let limit, let offset):
            return Self.baseURL + "/pokemon?limit=\(limit)&offset=\(offset)"
        case .getPokemonDetails(let id):
            return Self.baseURL + "/pokemon/\(id)"
        case .getAllTypes:
            return Self.baseURL + "/type"
        case .getPokemonByType(let url):
            return url
        }
    }
}

extension Constants.RequestEndpoint: HTTPMethodConvertible {
    var method: HTTPMethod {
        return .get
    }
}
