//
//  PokemonListView.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 20/04/2025.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject var viewModel: PokemonListViewModel

    var body: some View {
        VStack {
            Text("PokeBrowse")
                .font(.largeTitle)
                .bold()
                .padding(.top)
            
            TextField("Search", text: $viewModel.searchText)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(viewModel.filteredPokemon(searchText: viewModel.searchText)) { pokemon in
                        Button(action: { viewModel.pokemonClicked?(pokemon) }) {
                            PokemonCardView(pokemon: pokemon)
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.fetchPokemon()
        }
    }
}

#Preview {
    PokemonListView(viewModel: PokemonListViewModel())
}
