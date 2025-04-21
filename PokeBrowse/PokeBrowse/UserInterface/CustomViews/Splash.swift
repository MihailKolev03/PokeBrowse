//
//  Splash.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import SwiftUI

struct Splash: View {
    @State private var moveToTop = false

    var body: some View {
        ZStack {
            Color(.systemBackground).opacity(0.95)
                .ignoresSafeArea()

            VStack {
                Text("PokeBrowse")
                    .foregroundStyle(.black.opacity(0.8))
                    .font(.largeTitle)
                    .bold()
                    .padding()
                if moveToTop {
                    Spacer()
                }
            }

        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeInOut(duration: 0.8)) {
                    moveToTop = true
                }
            }
        }
    }
}

#Preview {
    Splash()
}
