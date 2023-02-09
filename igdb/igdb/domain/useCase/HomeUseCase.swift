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

class HomeUseCase: IHomeUseCase {
    
    let gameRepository: GameRepository
    
    init(gameRepository: GameRepository) {
        self.gameRepository = gameRepository
    }
    
    func execute(name: String? = nil) -> AnyPublisher<LoadableState<Home>, Never> {
        
        return gameRepository.fetchGames().compactMap { games in
            games.compactMap { [weak self] game in
                 self!.gameRepository.fetchImages(id:game.id).compactMap { images in
                    return Game(dto: game, covers: images.compactMap({ imageDTO in
                        Cover(dto: imageDTO)
                    }))
                }
            }
        }.convertToLoadedState()
        
        
        
        return gameRepository.fetchGames().compactMap {
            let games = $0.compactMap { dto in
                
                self.gameRepository.fetchImages(id:dto.id).compactMap { covers in
                    covers.compactMap {
                        Cover(dto: $0)
                    }
                }.catch({ error in
                    let result : [Cover] = []
                    return AnyPublisher(Just(result))
                })
                .compactMap { covers in
                    return [Game(dto: dto, covers: covers)]
                }
            }
            return Home(status: .home, games: games)
        }.convertToLoadedState()
            .eraseToAnyPublisher()
    }
    
    func getCover(id: Int) -> AnyPublisher<LoadableState<[Cover]>, Never> {
        return gameRepository.fetchImages(id: id).compactMap {
            $0.compactMap { dto in
                Cover(dto: dto)
            }
        }.convertToLoadedState()
            .eraseToAnyPublisher()
    }
}

class HomeUseCaseMock: IHomeUseCase {
    func getCover(id: Int) -> AnyPublisher<LoadableState<[Cover]>, Never> {
        return Result<[Cover],Never>.Publisher.init([])
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
