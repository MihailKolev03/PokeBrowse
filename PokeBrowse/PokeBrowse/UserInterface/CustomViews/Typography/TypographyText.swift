//
//  TypographyText.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import SwiftUI

struct TypographyText: View {
    let text: LocalizedStringKey
    let typography: Typography

    public init(text: String, typography: Typography) {
        self.text = LocalizedStringKey(text)
        self.typography = typography
    }
    
    public init(text: LocalizedStringKey, typography: Typography) {
        self.text = text
        self.typography = typography
    }

    public var body: Text {
        Text(text)
            .font(typography.value.font)
            .kerning(typography.value.letterSpacing)
    }
    
    var toText: Text {
        body
    }
}

#Preview {
    TypographyText(text: "Hello", typography: .title)
}
