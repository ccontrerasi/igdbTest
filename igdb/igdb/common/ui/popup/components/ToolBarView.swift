//
//  ToolBarView.swift
//
//
//  Created by Cristian Contreras on 18/1/23.
//

import SwiftUI
import Rswift

public struct ToolbarView: View {
    private let title: String
    private let buttons: [ToolbarButton]
    private let onButtonSelected: ((Int) -> Void)?
    private let logo: ImageResource?
    private let spacing: CGFloat

    @Environment(\.safeAreaInsets) var safeAreaInsets

    public init(
        title: String = "",
        logo: ImageResource? = nil,
        buttons: [ToolbarButton] = [],
        spacing: CGFloat = mediumBig,
        onButtonSelected: ((Int) -> Void)? = nil
    ) {
        self.title = title
        self.buttons = buttons
        self.onButtonSelected = onButtonSelected
        self.logo = logo
        self.spacing = spacing
    }
    
    public var body: some View {
        ZStack {
            Text(title).style(.titleNav)
            HStack(alignment: .center, spacing: spacing) {
                if let logo = logo {
                    Image(imageResource: logo)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: .infinity)
                }
                Spacer()
                ForEach(Array(buttons.enumerated()), id: \.element) { index, item in
                    Button {
                        onButtonSelected?(index)
                    } label: {
                        Image(imageResource: item.image)
                    }
                }
            }
        }
        .frame(height: 44)
        .padding(.horizontal, medium)
        .background(R.color.dum.blueDark)
        // 5 is the additional distance of the island https://useyourloaf.com/blog/iphone-14-screen-sizes/
        .padding(.top, safeAreaInsets.top > 50 ? -5 : 0)
    }
}

public struct ToolbarButton {
    let image: ImageResource
    
    public init(
        image: ImageResource
    ) {
        self.image = image
    }
}

extension ToolbarButton: Identifiable, Hashable {
    public static func == (lhs: ToolbarButton, rhs: ToolbarButton) -> Bool {
        return lhs.id == rhs.id
    }
    
    public var id: String { image.name }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarView()
    }
}
