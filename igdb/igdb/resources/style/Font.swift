//
//  Font.swift
//
//
//  Created by Cristian Contreras on 17/1/23.
//

import Foundation
import SwiftUI

extension Font {
    struct dum {
        static var titleSplash: Font { Font.custom(R.font.ralewayBold.fontName, size: 48) }
        static var titleWelcome: Font { Font.custom(R.font.ralewaySemiBold.fontName, size: 26) }
        static var regularSmall: Font { Font.custom(R.font.ralewayRegular.fontName, size: 13) }
        static var regularMedium: Font { Font.custom(R.font.ralewaySemiBold.fontName, size: 18) }
        static var regularBig: Font { Font.custom(R.font.ralewayRegular.fontName, size: 20) }
        static var semiBoldMedium: Font { Font.custom(R.font.ralewaySemiBold.fontName, size: 18) }
    }
}
