//
//  HomeUseCase.swift
//  dtiOurense
//
//  Created by Cristian Contreras on 6/2/23.
//

import Foundation
import Combine
import Moya

protocol IHomeUseCase {
    func execute(name: String?) -> AnyPublisher<LoadableState<Home>, Never>
}

class HomeUseCase: IHomeUseCase {
    
    let gameRepository: GameRepository
    
    init(gameRepository: GameRepository) {
        self.gameRepository = gameRepository
    }
    
    func execute(name: String? = nil) -> AnyPublisher<LoadableState<Home>, Never> {
        
        return gameRepository.fetchGames().compactMap {
            let games = $0.compactMap { dto in
                Game(dto: dto)
            }
            return Home(status: .home, games: games)
        }.convertToLoadedState()
            .eraseToAnyPublisher()
    }
}

class HomeUseCaseMock: IHomeUseCase {
    let gameMockup = [ Game(id: 0, name: "Game 1", createdAt: nil, url: "https://cdn.vox-cdn.com/thumbor/6I-IQtvx29OSQp0nZscVi7Ev9rA=/0x0:1920x1080/1200x675/filters:focal(807x387:1113x693)/cdn.vox-cdn.com/uploads/chorus_image/image/68510166/jbareham_201201_ecl1050_goty_2020_top_50_02.0.jpg"),
                       Game(id: 1, name: "Game 2", createdAt: nil, url: "https://i.insider.com/58c192e5402a6b1b008b51fe?width=750&format=jpeg&auto=webp"),
                       Game(id: 2, name: "Game 2", createdAt: nil, url: "https://i.pcmag.com/imagery/lineups/01d5pjEt4Ql4nGhu3XjCkDn-2..v1583082659.jpg"),
                       Game(id: 4, name: "Game 4", createdAt: nil, url: "https://cdn.vox-cdn.com/thumbor/6I-IQtvx29OSQp0nZscVi7Ev9rA=/0x0:1920x1080/1200x675/filters:focal(807x387:1113x693)/cdn.vox-cdn.com/uploads/chorus_image/image/68510166/jbareham_201201_ecl1050_goty_2020_top_50_02.0.jpg"),
                       Game(id: 5, name: "Game 5", createdAt: nil, url: "https://i.insider.com/58c192e5402a6b1b008b51fe?width=750&format=jpeg&auto=webp"),
                       Game(id: 6, name: "Game 6", createdAt: nil, url: "https://i.pcmag.com/imagery/lineups/01d5pjEt4Ql4nGhu3XjCkDn-2..v1583082659.jpg"),
    ]
    
    func execute(name: String? = nil) -> AnyPublisher<LoadableState<Home>, Never> {
        return Result<Home,Never>.Publisher.init(Home(status: .home, games: gameMockup))
            .convertToLoadedState()
            .eraseToAnyPublisher()
    }
}
