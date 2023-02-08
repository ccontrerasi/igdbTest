//
//  TextStyles.swift
//
//
//  Created by Cristian Contreras on 17/1/23.
//

import Foundation
import SwiftUI

public extension Font {
    static let title: Font = .custom(R.font.ralewaySemiBold.fontName, size: 24)
    static let itemMenu: Font = .custom(R.font.ralewayRegular.fontName, size: 18)
}

public enum TextStyle {
    case titleNav, titleListHome, itemList

    public var style: (font: Font, color: Color) {
        switch self {
        case .titleNav: return (.title, Color.white)
        case .titleListHome: return (.title, Color.black)
        case .itemList: return (.itemMenu, Color.black)
        }
    }
}

public extension View {
    func style(_ textStyle: TextStyle) -> some View {
        foregroundColor(textStyle.style.color)
            .font(textStyle.style.font)
    }
}

public extension Text {
    func style(_ textStyle: TextStyle) -> Text {
        foregroundColor(textStyle.style.color)
            .font(textStyle.style.font)
    }
}



