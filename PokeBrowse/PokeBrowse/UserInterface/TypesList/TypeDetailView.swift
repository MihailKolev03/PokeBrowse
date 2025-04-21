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
        VStack(spacing: 16) {
            title

            List {
                if viewModel.isLoading {
                    ProgressView()
                } else if viewModel.pokemonNames.isEmpty {
                    Text("Empty")
                } else {
                    ForEach(viewModel.pokemonNames, id: \.self) { name in
                        Text(name.capitalized)
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
            Text(viewModel.type.name.capitalized)
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
            }
            .padding()
        }
    }
}
