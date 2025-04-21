//
//  Font.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import SwiftUI

enum QuicksandFont: String {
    case light = "Quicksand-Light"
    case regular = "Quicksand-Regular"
    case medium = "Quicksand-Medium"
    case semiBold = "Quicksand-SemiBold"
    case bold = "Quicksand-Bold"
}

extension Font {
    static func quicksand(_ type: QuicksandFont, size: CGFloat) -> Font {
        return .custom(type.rawValue, size: size)
    }
}

extension UIFont {
    static func quicksand(_ type: QuicksandFont, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
