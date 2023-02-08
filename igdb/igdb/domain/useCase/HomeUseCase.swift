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
    
    let gameMockup = [ Game(id: 0, name: "Game 1", image: "https://cdn.vox-cdn.com/thumbor/6I-IQtvx29OSQp0nZscVi7Ev9rA=/0x0:1920x1080/1200x675/filters:focal(807x387:1113x693)/cdn.vox-cdn.com/uploads/chorus_image/image/68510166/jbareham_201201_ecl1050_goty_2020_top_50_02.0.jpg"),
                       Game(id: 1, name: "Game 2", image: "https://i.insider.com/58c192e5402a6b1b008b51fe?width=750&format=jpeg&auto=webp"),
                       Game(id: 2, name: "Game 2", image: "https://i.pcmag.com/imagery/lineups/01d5pjEt4Ql4nGhu3XjCkDn-2..v1583082659.jpg"),
    ]
    
    func execute(name: String? = nil) -> AnyPublisher<LoadableState<Home>, Never> {
        Result<Home, Never>.Publisher.init(Home(status: .home, games: gameMockup))
            .convertToLoadedState()
            .eraseToAnyPublisher()
    }
}
