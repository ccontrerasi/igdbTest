//
//  
//  HomeCoordinator.swift
//  dtiOurense
//
//  Created by Cristian Contreras on 6/2/23.
//
//  Created by Christian Contreras
//
import Foundation
import SwiftUI
import Combine

enum HomeTab {
    case start
    case search
    case map
    case book
    case config
}

protocol IHomeFlowStateProtocol: ObservableObject {
    var activeLink: HomeNavigationLink? { get set }
}

struct HomeCoordinator<State: IHomeFlowStateProtocol, Content: View>: View {
    @ObservedObject var state: State
    let content: () -> Content
    
    private var activeLink: Binding<HomeNavigationLink?> {
        $state.activeLink.map(get: { $0?.navigationLink }, set: { $0 })
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                content()
                navigationLinks
            }
        }
    }
    
    @ViewBuilder private var navigationLinks: some View {
        NavigationLink(tag: .goToDetail(), selection: activeLink, destination: goToDetail) { EmptyView() }        
    }
    
    private func goToDetail() -> some View {
        var id: Int?
        if case let .goToDetail(param) = state.activeLink {
            id = param
        }
        // TODO: CREATE THE NEW COORDINATOR
        return AnyView(Text("Vamos al detalle: \(id ?? -1)"))
        
    }
}
