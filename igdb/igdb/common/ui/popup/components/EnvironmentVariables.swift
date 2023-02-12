//
//  EnvironmentVariables.swift
//
//
//  Created by Cristian Contreras on 18/1/23.
//

import SwiftUI

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        let safeAreaInsets = keyWindow?.safeAreaInsets ?? .zero
        return EdgeInsets(top: safeAreaInsets.top, leading: safeAreaInsets.left, bottom: safeAreaInsets.bottom, trailing: safeAreaInsets.right)
    }
}

public extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }

    var bottomSafePadding: CGFloat {
        self[SafeAreaInsetsKey.self].bottom < medium ? medium : self[SafeAreaInsetsKey.self].bottom
    }
}
