//
//  LoadingView.swift
//
//
//  Created by Cristian Contreras on 24/1/23.
//

import SwiftUI

public struct LoadingView<Content: View>: View {
    @Binding private var isLoading: Bool
    private var content: () -> Content

    public init(
        isLoading: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        _isLoading = isLoading
        self.content = content
    }
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        _isLoading = .constant(true)
        self.content = content
    }

    public var body: some View {
        ZStack {
            ActivityIndicatorView(isAnimating: $isLoading)
                .frame(
                    maxHeight: .infinity,
                    alignment: .center
                )
            content()
                .opacity(isLoading ? 0.3 : 1)
                .allowsHitTesting(!isLoading)
        }
    }
}

public struct ActivityIndicatorView: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style = .medium

    public init(isAnimating: Binding<Bool>) {
        self._isAnimating = isAnimating
    }

    public func makeUIView(context _: UIViewRepresentableContext<ActivityIndicatorView>) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: style)
    }

    public func updateUIView(_ uiView: UIActivityIndicatorView, context _: UIViewRepresentableContext<ActivityIndicatorView>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct ActivityIndicatorViewPreview: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorView(isAnimating: .constant(true))
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("ActivityIndicatorView Preview")
    }
}
