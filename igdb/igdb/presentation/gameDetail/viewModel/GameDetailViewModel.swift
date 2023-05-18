//
//  
//  GameDetailViewModel.swift
//  igdbTests
//
//  Created by Cristian Contreras on 10/2/23.
//
//  Created by Christian Contreras
//
import Foundation
import Combine

protocol GameDetailViewModelProtocol: ObservableObject, IGameDetailFlowStateProtocol {
    var state: LoadableState<GameDetail> { get }
    func fetchGame()
}

final class GameDetailViewModel: ObservableObject, GameDetailViewModelProtocol, IGameDetailFlowStateProtocol {
    // MARK: - Properties
    @Published private(set) var state: LoadableState<GameDetail>
    @Published var activeLink: GameDetailNavigationLink?
    private let useCase: IGameDetailUseCase
    private let idGame: Int?
    
    init(useCase: IGameDetailUseCase,
         state: LoadableState<GameDetail> = .idle,
         idGame: Int? = nil) {
        self.useCase = useCase
        self.state = state
        self.idGame = idGame
    }
    
    // MARK: - Public
    func fetchGame() {
        state = .loading
        
        useCase
            .execute(id: idGame)
            .assign(to: &$state)
    }
}
