//
//  
//  GameDetailCoordinator.swift
//  igdbTests
//
//  Created by Cristian Contreras on 10/2/23.
//
//  Created by Christian Contreras
//
import Foundation
import SwiftUI

protocol IGameDetailFlowStateProtocol: ObservableObject {
    var activeLink: GameDetailNavigationLink? { get set }
}

struct GameDetailCoordinator<State: IGameDetailFlowStateProtocol, Content: View>: View {
    @ObservedObject var state: State
    let content: () -> Content
    
    private var activeLink: Binding<GameDetailNavigationLink?> {
        $state.activeLink.map(get: { $0?.navigationLink }, set: { $0 })
    }
    
    var body: some View {
        ZStack {
            content()
            navigationLinks
        }
    }
    
    @ViewBuilder private var navigationLinks: some View {
        NavigationLink(tag: .goToPage(), selection: activeLink, destination: goToPage) { EmptyView() }
    }
    
    private func goToPage() -> some View {
        var id: Int?
        if case let .goToPage(param) = state.activeLink {
            id = param
        }
        // TODO: CREATE THE NEW COORDINATOR
        return EmptyView()
    }
}
