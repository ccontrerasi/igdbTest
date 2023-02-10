//
//  
//  GameDetailNavigationLink.swift
//  igdbTests
//
//  Created by Cristian Contreras on 10/2/23.
//
//  Created by Christian Contreras
//
import Foundation
protocol IGameDetailNavigationLink: Identifiable {
    var navigationLink: GameDetailNavigationLink { get }
    var sheetItem: GameDetailNavigationLink? { get }
}

enum GameDetailNavigationLink: Hashable, IGameDetailNavigationLink {
    // EXAMPLE
    case goToPage(id: Int? = nil)
    
    var id: String {
        switch self {
        case let .goToPage(id):
            return "goToInfo: \(id ?? 0)"
        }
    }
    
    var navigationLink: GameDetailNavigationLink {
        switch self {
        default:
            return .goToPage()
        }
    }
    
    var sheetItem: GameDetailNavigationLink? {
        return nil
    }
}
