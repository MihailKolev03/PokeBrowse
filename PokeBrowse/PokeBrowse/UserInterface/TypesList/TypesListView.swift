//
//  TypesListView.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import SwiftUI

struct TypesListView: View {
    @StateObject var viewModel: TypesListViewModel

    var body: some View {
        VStack {
            Text("PokeTypes")
                .font(.largeTitle)
                .bold()
                .padding(.top)

            List(viewModel.types, id: \.name) { type in
                Button(action: { viewModel.typeClicked?(type) }) {
                    Text(type.name.capitalized)
                        .padding(.vertical, 6)
                }
            }
            .onAppear {
                viewModel.fetchTypes()
            }
        }
    }
}
