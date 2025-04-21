//
//  FavoritesListView.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import SwiftUI

struct FavoritesListView: View {
    @StateObject var viewModel: FavoritesListViewModel

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()

            VStack {
                pageTitle("Favorites")

                if viewModel.favoritePokemons.isEmpty {
                    TypographyText(text: "No favorites yet.", typography: .bodyMedium)
                        .foregroundColor(.gray)
                        .padding(.top, 40)
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(viewModel.favoritePokemons) { pokemon in
                                Button(action: { viewModel.pokemonClicked?(pokemon) }) {
                                    PokemonCardView(
                                        pokemon: pokemon,
                                        isFavorite: viewModel.isFavorite(pokemon),
                                        toggleFavorite: { viewModel.toggleFavorite(pokemon) }
                                    )
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadFavorites()
        }
    }
}

