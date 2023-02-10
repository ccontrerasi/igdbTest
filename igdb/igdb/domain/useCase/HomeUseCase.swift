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
    func getCover(id: Int) -> AnyPublisher<LoadableState<[Cover]>, Never>
}

struct Juego {
    let id: Int
    let cover: [ImageDTO]
}

class HomeUseCase: IHomeUseCase {
    
    let gameRepository: GameRepository
    
    init(gameRepository: GameRepository) {
        self.gameRepository = gameRepository
    }
    
    func execute(name: String? = nil) -> AnyPublisher<LoadableState<Home>, Never> {
        return gameRepository.fetchGames()
           .flatMap { games in
               games.publisher.setFailureType(to: Error.self)
           }
           .flatMap { [weak self] game -> AnyPublisher<Game, Error> in
               
               guard let `self` = self, let idCover = game.cover else {
                   return AnyPublisher<Game, Error>(Just(Game(dto: game))
                    .setFailureType(to: Error.self))
               }
               return self.gameRepository.fetchImage(id: idCover)
                  .mapError { $0 as Error }
                  .map { Game(dto:game, covers: $0.map({ imgDto in
                      Cover(dto: imgDto)
                  })) }
                  .eraseToAnyPublisher()
           }
           .collect().convertToLoadedState().map ({
               Home(status: .home, games: $0.getResult() ?? [])
           }).eraseToAnyPublisher().convertToLoadedState()
    }
    
    func getCover(id: Int) -> AnyPublisher<LoadableState<[Cover]>, Never> {
        return gameRepository.fetchImage(id: id).compactMap {
            $0.compactMap { imgDto in
                Cover(dto: imgDto)
            }
        }.convertToLoadedState()
            .eraseToAnyPublisher()
    }
}

class HomeUseCaseMock: IHomeUseCase {
    func getCover(id: Int) -> AnyPublisher<LoadableState<[Cover]>, Never> {
        return Result<[Cover],Never>.Publisher.init([Cover(dto: ImageDTO(id: 1, url: "https://i.pcmag.com/imagery/lineups/01d5pjEt4Ql4nGhu3XjCkDn-2..v1583082659.jpg"))])
            .convertToLoadedState()
            .eraseToAnyPublisher()
    }
    
    let gameMockup = [ Game(id: 0, name: "Game 1", createdAt: nil, url: "https://cdn.vox-cdn.com/thumbor/6I-IQtvx29OSQp0nZscVi7Ev9rA=/0x0:1920x1080/1200x675/filters:focal(807x387:1113x693)/cdn.vox-cdn.com/uploads/chorus_image/image/68510166/jbareham_201201_ecl1050_goty_2020_top_50_02.0.jpg", covers: nil),
                       Game(id: 1, name: "Game 2", createdAt: nil, url: "https://i.insider.com/58c192e5402a6b1b008b51fe?width=750&format=jpeg&auto=webp", covers: nil),
                       Game(id: 2, name: "Game 2", createdAt: nil, url: "https://i.pcmag.com/imagery/lineups/01d5pjEt4Ql4nGhu3XjCkDn-2..v1583082659.jpg", covers: nil),
                       Game(id: 4, name: "Game 4", createdAt: nil, url: "https://cdn.vox-cdn.com/thumbor/6I-IQtvx29OSQp0nZscVi7Ev9rA=/0x0:1920x1080/1200x675/filters:focal(807x387:1113x693)/cdn.vox-cdn.com/uploads/chorus_image/image/68510166/jbareham_201201_ecl1050_goty_2020_top_50_02.0.jpg", covers: nil),
                       Game(id: 5, name: "Game 5", createdAt: nil, url: "https://i.insider.com/58c192e5402a6b1b008b51fe?width=750&format=jpeg&auto=webp", covers: nil),
                       Game(id: 6, name: "Game 6", createdAt: nil, url: "https://i.pcmag.com/imagery/lineups/01d5pjEt4Ql4nGhu3XjCkDn-2..v1583082659.jpg", covers: nil),
    ]
    
    func execute(name: String? = nil) -> AnyPublisher<LoadableState<Home>, Never> {
        return Result<Home,Never>.Publisher.init(Home(status: .home, games: gameMockup))
            .convertToLoadedState()
            .eraseToAnyPublisher()
    }
}
