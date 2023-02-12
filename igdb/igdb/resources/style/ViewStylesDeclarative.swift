//
//  ViewStylesDeclarative.swift
//
//
//  Created by Cristian Contreras on 5/2/23.
//

import Foundation
import Rswift
import SwiftUI

public struct ViewStyleHomeListBackground: ViewModifier {
    public init() { }
    public func body(content: Content) -> some View {
        content
            .background(Color.white.opacity(0.6))
    }
}

public struct TabBarViewStyle: ViewModifier {
    public init() { }
    public func body(content: Content) -> some View {
        content
            .foregroundColor(R.color.dum.blueDark)
            .background(R.color.dum.blueDark)
    }
}
