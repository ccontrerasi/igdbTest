//
//  File.swift
//
//
//  Created by Cristian Contreras on 18/1/23.
//

import SwiftUI

@ViewBuilder
public func HostingChildView<Content: View>(id: String, content: Content) -> some View {
    HostingChildGenericView(id: id, content: content)
}

struct HostingChildGenericView<Content:View>: View {
    @EnvironmentObject var environment: EnviromentContainer
    let id: String
    let content: Content

    public init(id: String, content: Content) {
        self.id = id
        self.content = content
    }

    public var body: some View {
        // TODO: Review why?
        /*guard let _ = environment.viewProvider(id: id) else {
            fatalError("No view configured for \(id)")
        }*/
        return content
    }
}

private func viewProviderId(_ id: String) -> String { "vp[\(id)]" }

extension EnviromentContainer {
    func viewProvider(id: String) -> (() -> AnyView)? {
        get(id: viewProviderId(id)) as? (() -> AnyView)
    }
}
