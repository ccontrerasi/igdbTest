//
//  Game.swift
//  igdb
//
//  Created by Cristian Contreras on 8/2/23.
//

import Foundation

struct Game: Codable {
    let id: Int
    let name: String
    let createdAt: Date?
    let url: String?
    let covers: [Cover]?
    
    init(id: Int,
         name: String,
         createdAt: Date?,
         url: String?,
         covers: [Cover]?) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
        self.url = url
        self.covers = covers
    }
    
    init(dto: GameDTO, covers: [Cover]? = nil) {
        id = dto.id
        name = dto.name
        createdAt = dto.createdAt
        url = dto.url
        self.covers = covers
    }
}
