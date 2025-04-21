//
//  PokemonCardView.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 20/04/2025.
//

import SwiftUI

struct PokemonCardView: View {
    let pokemon: Pokemon
    let isFavorite: Bool
    let toggleFavorite: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            AsyncImage(url: URL(string: pokemon.imageURL)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                case .failure:
                    Image(systemName: "xmark.octagon")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                default:
                    ProgressView()
                }
            }

            TypographyText(text: pokemon.name.capitalized, typography: .bodyRegular)
                .foregroundColor(.primary)

            Button(action: toggleFavorite) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(.red)
                    .imageScale(.large)
            }
            .buttonStyle(.plain)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3)
    }
}
