//
//  GameDTO.swift
//  igdb
//
//  Created by Cristian Contreras on 8/2/23.
//

import Foundation

struct GameDTO: Codable {
    let id: Int
    let category: Int
    let createdAt: Date
    let externalGames: [Int]?
    let firstReleaseDate: Int?
    let gameModes: [Int]?
    let genres: [Int]?
    let name: String
    let platforms: [Int]?
    let releaseDates: [Int]?
    let screenshots: [Int]?
    let similarGames: [Int]?
    let slug: String
    let summary: String?
    let tags: [Int]?
    let updatedAt: Date
    let url: String
    let websites: [Int]?
    let checksum: String
    let ageRatings: [Int]?
    let alternativeNames: [Int]?
    let collection: Int?
    let cover: Int?
    let franchises: [Int]?
    let involvedCompanies: [Int]?
    let keywords: [Int]?
    let playerPerspectives: [Int]?
    let status: Int?
    let themes: [Int]?
    let artworks: [Int]?
    let languageSupports: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case id, category
        case createdAt = "created_at"
        case externalGames = "external_games"
        case firstReleaseDate = "first_release_date"
        case gameModes = "game_modes"
        case genres, name, platforms
        case releaseDates = "release_dates"
        case screenshots
        case similarGames = "similar_games"
        case slug, summary, tags
        case updatedAt = "updated_at"
        case url, websites, checksum
        case ageRatings = "age_ratings"
        case alternativeNames = "alternative_names"
        case collection, cover, franchises
        case involvedCompanies = "involved_companies"
        case keywords
        case playerPerspectives = "player_perspectives"
        case status, themes, artworks
        case languageSupports = "language_supports"
    }
}
