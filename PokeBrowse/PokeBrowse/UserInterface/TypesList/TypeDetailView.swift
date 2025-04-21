//
//  TypeDetailView.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import SwiftUI

struct TypeDetailView: View {
    @StateObject var viewModel: TypeDetailViewModel

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()

            VStack(spacing: 16) {
                title

                List {
                    if viewModel.isLoading {
                        ProgressView()
                    } else if viewModel.pokemonNames.isEmpty {
                        TypographyText(text: "Empty", typography: .bodyRegular)
                    } else {
                        ForEach(viewModel.pokemonNames, id: \.self) { name in
                            TypographyText(text: name.capitalized, typography: .bodyRegular)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchPokemonOfType()
        }
        .navigationBarBackButtonHidden()
    }

    private var title: some View {
        ZStack {
            pageTitle(viewModel.type.name.capitalized)

            HStack {
                Button(action: { viewModel.goBack?() }) {
                    Image(systemName: "arrow.backward")
                        .renderingMode(.template)
                        .foregroundStyle(.black.opacity(0.8))
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 12)
        }
    }
}
