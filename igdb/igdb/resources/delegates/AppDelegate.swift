//
//  AppDelegate.swift
//
//
//  Created by Cristian Contreras 
//

import Foundation
import UIKit
import SwiftUI
import Combine
import Moya
import Swinject

class AppDelegate: UIResponder, UIApplicationDelegate, ObservableObject {
    private var container: Container!
    static private(set) var instance: AppDelegate! = nil
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppDelegate.instance = self
        container = Container() { [weak self] container in
            guard let self = self else { return }
            self.loadService(container)
            self.loadRepositories(container)
            self.loadUseCases(container)
            self.loadViewModels(container)
            self.loadViewControllers(container)
            self.loadCoordinators(container)
        }
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
            let configuration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
            if connectingSceneSession.role == .windowApplication {
                configuration.delegateClass = SceneDelegate.self
            }
            return configuration
        }    
}

extension AppDelegate {
    func getCoordiantor<T:View>(_ type: T.Type) -> some View {
        return container.resolve(type)
    }
    
    private func loadService(_ container: Container){
        container.register(MoyaProvider<ApiServices>.self) { r in
            return MoyaProvider<ApiServices>(
                plugins: [VerbosePlugin(verbose: true)])
        }
    }
    
    private func loadRepositories(_ container: Container) {
        container.register(GameRepository.self) { r in
            return GameRepository(provider: r.resolve(MoyaProvider<ApiServices>.self)!)
        }
    }

    private func loadUseCases(_ container: Container) {
        container.register(HomeUseCase.self) { r in
            return HomeUseCase(gameRepository: r.resolve(GameRepository.self)!)
        }
    }
    private func loadViewModels(_ container: Container) {
        container.register(HomeViewModel.self) { r in
            let uc = r.resolve(HomeUseCase.self)!
            return HomeViewModel(useCase: uc)
        }
    }
    
    private func loadViewControllers(_ container: Container) {
        container.register(HomeViewController.self) { r in
            let vm = r.resolve(HomeViewModel.self)!
            return HomeViewController(viewModel: vm)
        }
    }
    
    private func loadCoordinators(_ container: Container) {
        container.register(HomeCoordinator<HomeViewModel, HomeViewController>.self) { r in
            let vm = r.resolve(HomeViewModel.self)!
            let vc = r.resolve(HomeViewController.self)!
            return HomeCoordinator(state: vm, content: { vc })
        }        
    }
}
