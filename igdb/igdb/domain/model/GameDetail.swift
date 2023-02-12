//
//  
//  GameDetail.swift
//  igdbTests
//
//  Created by Cristian Contreras on 10/2/23.
//
//
import Foundation

struct GameDetail {
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
    var covers: [Cover]?

    init(dto: GameDTO, covers: [Cover]? = nil){
        id = dto.id
        category = dto.category
        createdAt = dto.createdAt
        externalGames = dto.externalGames
        firstReleaseDate = dto.firstReleaseDate
        gameModes = dto.gameModes
        genres = dto.genres
        name = dto.name
        platforms = dto.platforms
        releaseDates = dto.releaseDates
        screenshots = dto.screenshots
        similarGames = dto.similarGames
        slug = dto.slug
        summary = dto.summary
        tags = dto.tags
        updatedAt = dto.updatedAt
        url = dto.url
        websites = dto.websites
        checksum = dto.checksum
        ageRatings = dto.ageRatings
        alternativeNames = dto.alternativeNames
        collection = dto.collection
        cover = dto.cover
        franchises = dto.franchises
        involvedCompanies = dto.involvedCompanies
        keywords = dto.keywords
        playerPerspectives = dto.playerPerspectives
        status = dto.status
        themes = dto.themes
        artworks = dto.artworks
        languageSupports = dto.languageSupports
        self.covers = covers
    }
}
