//
//  ScrollProxy.swift
//
//
//  Created by Cristian Contreras
//

import Foundation
import SwiftUI

public class ScrollProxy: ObservableObject {
    @Published var value: Int = 0

    public init() { }

    public func scroll() {
        value += 1
    }
}

public struct ScrollToTop: ViewModifier {
    @ObservedObject private var scrollProxy: ScrollProxy
    private let topViewId: UUID

    public init(
        scrollProxy: ScrollProxy,
        topViewId: UUID
    ) {
        self.scrollProxy = scrollProxy
        self.topViewId = topViewId
    }

    public func body(content: Content) -> some View {
        ScrollViewReader { proxy in
            content.onChange(of: scrollProxy.value) { _ in
                withAnimation {
                    proxy.scrollTo(topViewId, anchor: .top)
                }
            }
        }
    }
}
