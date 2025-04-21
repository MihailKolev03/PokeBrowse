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
        NavigationStack {
            List(viewModel.types, id: \.name) { type in
                NavigationLink(destination: TypeDetailView(type: type)) {
                    Text(type.name.capitalized)
                        .padding(.vertical, 6)
                }
            }
            .navigationTitle("Types")
            .onAppear {
                viewModel.fetchTypes()
            }
        }
    }
}

#Preview {
    TypesListView(viewModel: TypesListViewModel())
}
