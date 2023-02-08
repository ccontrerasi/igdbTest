//
//  MoyaProvider+Extension.swift
//  marvelExample
//
//  Created by Cristian Contreras on 2/2/23.
//

import Foundation
import Combine
import Moya

extension MoyaProvider {
    func requestPublisher<T:Codable>(_ target: Target, typeResult: T.Type, callbackQueue: DispatchQueue? = nil) -> AnyPublisher<T, Error> {
        return requestPublisher(target).tryCompactMap ({ result in
#if DEBUG
            if let data = try? result.mapJSON() {
                print("++ execution service called : \(data)")
            }
#endif
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(.dateFromServerFull)
            if (result.statusCode == 200){
                let json = try decoder.decode(T.self, from: result.data)
                return json
            }
            return nil
        }).mapError({ _ in
            // TODO: define all possible errors
            return RequestError.commonError
        }).subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
        .eraseToAnyPublisher()
    }
}
