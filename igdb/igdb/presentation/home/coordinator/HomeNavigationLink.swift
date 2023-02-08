//
//  
//  HomeNavigationLink.swift
//  dtiOurense
//
//  Created by Cristian Contreras on 6/2/23.
//
//  Created by Christian Contreras
//
import Foundation
protocol IHomeNavigationLink: Identifiable {
    var navigationLink: HomeNavigationLink { get }
    var sheetItem: HomeNavigationLink? { get }
}

enum HomeNavigationLink: Hashable, IHomeNavigationLink {
    // EXAMPLE
    case goToPage(id: Int? = nil)
    
    var id: String {
        switch self {
        case let .goToPage(id):
            return "goToInfo: \(id ?? 0)"
        }
    }
    
    var navigationLink: HomeNavigationLink {
        switch self {
        default:
            return .goToPage()
        }
    }
    
    var sheetItem: HomeNavigationLink? {
        return nil
    }
}
