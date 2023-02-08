//
//  HomeUseCase.swift
//  dtiOurense
//
//  Created by Cristian Contreras on 6/2/23.
//

import Foundation
import Combine

protocol IHomeUseCase {
    func execute(name: String?) -> AnyPublisher<LoadableState<Home>, Never>
}

class HomeUseCase: IHomeUseCase {
    func execute(name: String? = nil) -> AnyPublisher<LoadableState<Home>, Never> {
        Result<Home, Never>.Publisher.init(Home(status: .splash))
            .convertToLoadedState()
            .eraseToAnyPublisher()
    }
}
