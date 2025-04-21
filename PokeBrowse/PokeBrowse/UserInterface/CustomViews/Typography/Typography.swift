//
//  Typography.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import SwiftUI

struct TypographyData {
    let letterSpacing: CGFloat
    let font: Font
}

public enum Typography {
    case title
    case bodyRegular
    case bodyMedium
    case label

    var value: TypographyData {
        switch self {
        case .title:
            return TypographyData(letterSpacing: 0, font: .quicksand(.bold, size: 40))
        case .bodyRegular:
            return TypographyData(letterSpacing: 0, font: .quicksand(.regular, size: 16))
        case .bodyMedium:
            return TypographyData(letterSpacing: 0, font: .quicksand(.medium, size: 16))
        case .label:
            return TypographyData(letterSpacing: 0, font: .quicksand(.regular, size: 12))
        }
    }
}
