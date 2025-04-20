//
//  PokemonCardView.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 20/04/2025.
//

import SwiftUI

struct PokemonCardView: View {
    let pokemon: Pokemon

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: pokemon.imageURL)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                case .failure(_):
                    Image(systemName: "xmark.octagon")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                default:
                    ProgressView()
                }
            }
            Text(pokemon.name.capitalized)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .padding()
        .background(Color.yellow.opacity(0.2))
        .cornerRadius(16)
        .shadow(radius: 2)
    }
}
