//
//  TypeListResponse.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import Foundation

struct TypeListResponse: Decodable {
    let results: [NamedAPIResource]
}
