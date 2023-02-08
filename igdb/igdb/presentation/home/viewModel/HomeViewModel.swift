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
}

final class HomeViewModel: ObservableObject, HomeViewModelProtocol, IHomeFlowStateProtocol {

    // MARK: - Properties
    @Published private(set) var state: LoadableState<Home> = .idle
    @Published var activeLink: HomeNavigationLink?
    @Published var showWelcome: Bool = false
    @Published var currentTab: HomeTab = .start
    private let useCase: HomeUseCase
        
    init(useCase: HomeUseCase) {
        self.useCase = useCase
    }
    
    // MARK: - Public
    func welcomeShowed() {
        Preferences.showWelcome(false)
        state = .result(Home(status: .home))
        showWelcome = false
    }
    
    func launchLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            if !Preferences.showWelcome() {
                self?.state = .result(Home(status: .home))
            } else {
                self?.showWelcome = Preferences.showWelcome()
            }
        }
    }
}
