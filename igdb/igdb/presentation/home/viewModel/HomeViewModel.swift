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
    @Published private(set) var state: LoadableState<Home> = .idle
    @Published var activeLink: HomeNavigationLink?
    @Published var showWelcome: Bool = false
    @Published var currentTab: HomeTab = .start
    private let useCase: IHomeUseCase
        
    init(useCase: IHomeUseCase) {
        self.useCase = useCase
    }
    
    // MARK: - Public
    func welcomeShowed() {
        Preferences.showWelcome(false)
        state = .result(Home(status: .home, games: []))
        showWelcome = false
    }
    
    func launchLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            guard let `self` = self else { return }
            if !Preferences.showWelcome() {
                self.state = .loading
                self.useCase.execute(name: nil)
                    .assign(to: &self.$state)
            } else {
                self.showWelcome = Preferences.showWelcome()
            }
        }
    }
    
    func goToDetail(id: Int) {
        activeLink = .goToDetail(id: id)
    }
}
