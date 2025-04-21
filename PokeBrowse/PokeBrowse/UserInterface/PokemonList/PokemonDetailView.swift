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
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()

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

                    pageTitle(details.name.capitalized)

                    TypographyText(text: "ID: \(details.id)", typography: .bodyRegular)
                    TypographyText(text: "Height: \(details.height)", typography: .bodyRegular)
                    TypographyText(text: "Weight: \(details.weight)", typography: .bodyRegular)

                    HStack {
                        TypographyText(text: "Types:", typography: .bodyMedium)

                        ForEach(details.types, id: \.self) { type in
                            TypographyText(text: "Types:", typography: .bodyRegular)
                                .padding(6)
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }

                    Spacer()
                } else {
                    EmptyView()
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchDetails()
        }
        .navigationBarBackButtonHidden()
    }

    private var title: some View {
        ZStack {
            pageTitle(viewModel.pokemon.name.capitalized)

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
