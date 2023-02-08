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
    func fetchGames() -> AnyPublisher<[GameDTO], Error>
}

class GameRepository: IGameRepository {
    private let provider: MoyaProvider<ApiServices>
    
    init(provider: MoyaProvider<ApiServices>){
        self.provider = provider
    }
    
    func fetchGames() -> AnyPublisher<[GameDTO], Error> {
        provider.requestPublisher(.fetchGames, typeResult: [GameDTO].self)
    }
}
