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
    case goToDetail(id: Int? = nil)
    
    var id: String {
        switch self {
        case let .goToDetail(id):
            return "goToDetail: \(id ?? 0)"
        }
    }
    
    var navigationLink: HomeNavigationLink {
        switch self {
        default:
            return .goToDetail()
        }
    }
    
    var sheetItem: HomeNavigationLink? {
        return nil
    }
}
