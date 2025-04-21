//
//  PokemonDetailView.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 20/04/2025.
//

import SwiftUI

struct PokemonDetailView: View {
    @StateObject var viewModel: PokemonDetailViewModel

    var body: some View {
        VStack {
            title

            if viewModel.isLoading {
                ProgressView()
            } else if let details = viewModel.details {
                AsyncImage(url: URL(string: details.imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                } placeholder: {
                    ProgressView()
                }

                Text(details.name.capitalized)
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)

                Text("ID: \(details.id)")
                Text("Height: \(details.height)")
                Text("Weight: \(details.weight)")

                HStack {
                    Text("Types:")
                        .bold()
                    ForEach(details.types, id: \.self) { type in
                        Text(type.capitalized)
                            .padding(6)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(8)
                    }
                }

                Spacer()
            } else {
                Text("Error.")
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchDetails()
        }
        .navigationBarBackButtonHidden()
    }

    private var title: some View {
        ZStack {
            Text(viewModel.pokemon.name.capitalized)
                .foregroundStyle(.black.opacity(0.8))
                .font(.largeTitle)
                .bold()
            HStack {
                Button(action: { viewModel.goBack?() }) {
                    Image(systemName: "arrow.backward")
                        .renderingMode(.template)
                        .foregroundStyle(.black.opacity(0.8))
                }
                
                Spacer()

                Button(action: {
                    viewModel.toggleFavorite()
                }) {
                    Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                }
            }
        }
    }
}
