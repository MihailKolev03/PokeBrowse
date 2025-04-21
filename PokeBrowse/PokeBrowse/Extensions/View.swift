//
//  View.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import SwiftUI

extension View {
    func pageTitle(_ text: String) -> some View {
        TypographyText(text: text, typography: .title)
            .foregroundColor(.primary)
            .padding(.top, 12)
    }
}
