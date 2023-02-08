//
//  
//  Start.swift
//  dtiOurense
//
//  Created by Cristian Contreras on 7/2/23.
//
//
import Foundation
import Rswift

struct Home : Codable {
    let status: MainState
}

enum MainState: Codable {
    case splash
    case home
}
