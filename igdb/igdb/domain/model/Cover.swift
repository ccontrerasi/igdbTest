//
//  Image.swift
//  igdb
//
//  Created by Cristian Contreras on 8/2/23.
//

import Foundation

struct Cover: Codable {
    let id: Int
    let url: String
    
    init(dto: ImageDTO){
        id = dto.id
        url = "https:\(dto.url)"
    }
}
