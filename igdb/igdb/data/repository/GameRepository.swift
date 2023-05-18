//
//  GameRepository.swift
//  igdb
//
//  Created by Cristian Contreras on 8/2/23.
//

import Foundation
import Combine
import Moya

protocol IGameRepository {
    func fetchGames(offset: Int) -> AnyPublisher<[GameDTO], Error>
    func fetchImage(id: Int) -> AnyPublisher<[ImageDTO], Error>
    func fetchGame(id: Int) -> AnyPublisher<GameDTO, Error>
}

final class GameRepository: IGameRepository {
    private let provider: MoyaProvider<ApiServices>
    
    init(provider: MoyaProvider<ApiServices>){
        self.provider = provider
    }
    
    func fetchGames(offset: Int) -> AnyPublisher<[GameDTO], Error> {
        provider.requestPublisher(.fetchGames(offset: offset), typeResult: [GameDTO].self)
    }
    
    func fetchImage(id: Int) -> AnyPublisher<[ImageDTO], Error> {
        provider.requestPublisher(.fetchImageGame(id: id), typeResult: [ImageDTO].self)
    }
    
    func fetchGame(id: Int) -> AnyPublisher<GameDTO, Error> {
        provider.requestPublisher(.fetchGame(id: id), typeResult: [GameDTO].self).flatMap { games -> AnyPublisher<GameDTO, Error> in
            return AnyPublisher<GameDTO, Error>(Just(games.first!)
                .setFailureType(to: Error.self)).eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
}
