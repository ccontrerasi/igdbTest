//
//  GameRempositoryMockup.swift
//  igdbTests
//
//  Created by Cristian Contreras on 10/2/23.
//

import Foundation
import Combine
@testable import igdb

class GameRepositoryMockup : IGameRepository {
    func fetchGames() -> AnyPublisher<[GameDTO], Error> {
        guard let path = Bundle(for: GameRepositoryMockup.self).path(forResource: "games.json", ofType: nil) else {
            return Fail(error: NSError(domain: "File not found", code: -10001, userInfo: nil)).eraseToAnyPublisher()
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return Fail(error: NSError(domain: "Error reading file", code: -10002, userInfo: nil)).eraseToAnyPublisher()
        }
        
        guard let games = try? JSONDecoder().decode([GameDTO].self, from: data) else {
            return Fail(error: NSError(domain: "Error parsing file", code: -10003, userInfo: nil)).eraseToAnyPublisher()
        }
        
        return AnyPublisher<[GameDTO], Error>(Just(games).setFailureType(to: Error.self)).eraseToAnyPublisher()
    }
    
    func fetchImage(id: Int) -> AnyPublisher<[ImageDTO], Error> {
        guard let path = Bundle(for: GameRepositoryMockup.self).path(forResource: "images.json", ofType: nil) else {
            return Fail(error: NSError(domain: "File not found", code: -10001, userInfo: nil)).eraseToAnyPublisher()
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return Fail(error: NSError(domain: "Error reading file", code: -10002, userInfo: nil)).eraseToAnyPublisher()
        }
        
        guard let images = try? JSONDecoder().decode([ImageDTO].self, from: data) else {
            return Fail(error: NSError(domain: "Error parsing file", code: -10003, userInfo: nil)).eraseToAnyPublisher()
        }
        
        return AnyPublisher<[ImageDTO], Error>(Just(images).setFailureType(to: Error.self)).eraseToAnyPublisher()
    }
    
    
}
