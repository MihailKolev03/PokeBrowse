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
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()

            VStack {
                pageTitle("PokeTypes")

                List(viewModel.types, id: \.name) { type in
                    Button(action: { viewModel.typeClicked?(type) }) {
                        TypographyText(text: type.name.capitalized, typography: .bodyRegular)
                            .foregroundColor(.primary)
                            .padding(.vertical, 8)
                    }
                }
                .listStyle(.insetGrouped)
                .onAppear {
                    viewModel.fetchTypes()
                }
            }
        }
    }
}
