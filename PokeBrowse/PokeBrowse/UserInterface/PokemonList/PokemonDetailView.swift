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

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    title

                    if viewModel.isLoading {
                        ProgressView()
                    } else if let details = viewModel.details {
                        
                        AsyncImage(url: URL(string: details.imageURL)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                                .padding(.top)
                        } placeholder: {
                            ProgressView()
                        }

                        pageTitle(details.name.capitalized)

                        Group {
                            TypographyText(text: "ID: \(details.id)", typography: .bodyRegular)
                            TypographyText(text: "Height: \(details.height)", typography: .bodyRegular)
                            TypographyText(text: "Weight: \(details.weight)", typography: .bodyRegular)
                            TypographyText(text: "Base Experience: \(details.baseExperience)", typography: .bodyRegular)
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            TypographyText(text: "Types:", typography: .bodyMedium)
                            HStack {
                                ForEach(details.types, id: \.self) { type in
                                    TypographyText(text: type.capitalized, typography: .bodyRegular)
                                        .padding(6)
                                        .background(Color.blue.opacity(0.2))
                                        .cornerRadius(8)
                                }
                            }
                        }

                        Divider()

                        VStack(alignment: .leading, spacing: 4) {
                            TypographyText(text: "Abilities:", typography: .bodyMedium)
                            ForEach(details.abilities, id: \.self) { ability in
                                TypographyText(text: ability.capitalized, typography: .bodyRegular)
                            }
                        }

                        Divider()

                        VStack(alignment: .leading, spacing: 4) {
                            TypographyText(text: "Stats:", typography: .bodyMedium)
                            ForEach(details.stats) { stat in
                                HStack {
                                    TypographyText(text: stat.name.capitalized, typography: .bodyRegular)
                                    Spacer()
                                    TypographyText(text: "\(stat.baseValue)", typography: .bodyRegular)
                                }
                            }
                        }

                        Spacer()
                    } else {
                        Text("Unable to load Pokémon data.")
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
            }
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
            .padding(.horizontal)
            .padding(.top, 12)
        }
    }
}
