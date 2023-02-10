//
//  
//  HomeViewModel.swift
//  dtiOurense
//
//  Created by Cristian Contreras on 6/2/23.
//
//  Created by Christian Contreras
//
import Foundation
import Combine
import SwiftUI

protocol HomeViewModelProtocol: ObservableObject {
    func welcomeShowed()
    func launchLoading()
    func goToDetail(id: Int)
}

final class HomeViewModel: ObservableObject, HomeViewModelProtocol, IHomeFlowStateProtocol {

    // MARK: - Properties
    @Published private var state: LoadableState<Home>
    @Published private(set) var statePaginated: LoadableState<Home>
    @Published var activeLink: HomeNavigationLink?
    @Published var showWelcome: Bool = false
    @Published var currentTab: HomeTab = .start
    @Published var isLoading: Bool = false
    private let useCase: IHomeUseCase
    private var cancellables: [AnyCancellable] = []
    
    // As we paginated, we store a private state
    private var games: [Game] = []
    
    init(useCase: IHomeUseCase, state: LoadableState<Home> = .idle) {
        self.useCase = useCase
        self.statePaginated = state
        switch state {
        case .idle:
            self.state = .idle
        case .loading:
            self.state = .loading
        case .failed(let requestError):
            self.state = .failed(requestError)
        case .result(let value):
            self.state = .result(value)
        }
    }
    
    // MARK: - Public
    func welcomeShowed() {
        Preferences.showWelcome(false)
        statePaginated = .result(Home(status: .home, games: []))
        showWelcome = false
    }
    
    func loadNextGames() {
        isLoading = true
        cancellables.removeAll()
        useCase.execute(name: nil, offset: games.count).sink { [weak self] state in
            guard let `self` = self else { return }
            self.isLoading = false
            switch state {
            case .result(let home):
                self.games += home.games
                let newHome = Home(status: home.status, games: self.games)
                self.statePaginated = .result(newHome)
                break
            default:
                self.statePaginated = state
            }
        }.store(in: &cancellables)
    }
    
    func launchLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            guard let `self` = self else { return }
            if !Preferences.showWelcome() {
                self.loadNextGames()
            } else {
                self.showWelcome = Preferences.showWelcome()
            }
        }
    }
    
    func goToDetail(id: Int) {
        activeLink = .goToDetail(id: id)
    }
}
