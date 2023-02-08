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
    
    init(id: Int,
         name: String,
         createdAt: Date?,
         url: String?) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
        self.url = url
    }
    
    init(dto: GameDTO) {
        id = dto.id
        name = dto.name ?? ""
        createdAt = dto.createdAt
        url = dto.url
    }
}
