//
//  
//  GameDetailUseCase.swift
//  igdbTests
//
//  Created by Cristian Contreras on 10/2/23.
//
//
import Foundation
import Combine

protocol IGameDetailUseCase {
    func execute(id: Int?) -> AnyPublisher<LoadableState<GameDetail>, Never>
}

class GameDetailUseCase: IGameDetailUseCase {
    
    let gameRepository: IGameRepository
    
    init(gameRepository: IGameRepository) {
        self.gameRepository = gameRepository
    }
    
    // MARK: init
    func execute(id: Int?) -> AnyPublisher<LoadableState<GameDetail>, Never> {
        
        guard let id = id else { return AnyPublisher(Just(.failed(RequestError.commonError)))}
        
        return gameRepository.fetchGame(id: id).flatMap { [weak self] game -> AnyPublisher<GameDetail, Error> in
            guard let `self` = self, let idCover = game.cover else {
                return AnyPublisher<GameDetail, Error>(Just(GameDetail(dto: game))
                    .setFailureType(to: Error.self))
            }
            return self.gameRepository.fetchImage(id: idCover)
                .mapError { $0 as Error }
                .map { GameDetail(dto:game, covers: $0.map({ imgDto in
                    Cover(dto: imgDto)
                })) }
                .eraseToAnyPublisher()
        }.collect()
            .flatMap { games -> AnyPublisher<GameDetail, Error> in
                return AnyPublisher<GameDetail, Error>(Just(games.first!)
                    .setFailureType(to: Error.self)).eraseToAnyPublisher()
            }
            .convertToLoadedState().eraseToAnyPublisher()
    }
}

class GameDetailUseCaseMock: IGameDetailUseCase {
    func execute(id: Int?) -> AnyPublisher<LoadableState<GameDetail>, Never> {
        
        let gameMock = GameDTO(id: 1, category: 1,
                               createdAt: Date(), externalGames: nil, firstReleaseDate: nil, gameModes: nil,
                               genres: nil, name: "Description game", platforms: nil, releaseDates: nil,
                               screenshots: nil, similarGames: nil, slug: "slg", summary: nil, tags: nil,
                               updatedAt: Date(), url: "https://google.es", websites: nil, checksum: "Sumaryzed",
                               ageRatings: nil, alternativeNames: nil, collection: nil, cover: nil,
                               franchises: nil, involvedCompanies: nil, keywords: nil, playerPerspectives: nil,
                               status: nil, themes: nil, artworks: nil, languageSupports: nil)
        return Result<GameDetail,Never>.Publisher.init(GameDetail(dto: gameMock))
            .convertToLoadedState()
            .eraseToAnyPublisher()
    }
}
