//
//  Publisher+Extensions.swift
//  marvelExample
//
//  Created by Cristian Contreras on 3/2/23.
//

import Foundation
import Combine

extension Publisher {
    
    func flatMapLatest<T: Publisher>(_ transform: @escaping (Self.Output) -> T) -> Publishers.SwitchToLatest<T, Publishers.Map<Self, T>> where T.Failure == Self.Failure {
        map(transform).switchToLatest()
    }
    
    func convertToLoadedState(checkPopupError: Bool = true) -> AnyPublisher<LoadableState<Output>, Never> {
        self.map(LoadableState.result)
            .catch({ error -> AnyPublisher<LoadableState<Output>, Never> in
                guard let requestError = error as? RequestError else {
                    return AnyPublisher(Just(.failed(RequestError.commonError)))
                }
                
                if checkPopupError {
                    displayPopupIfPreceed(requestError)
                }
                
                return AnyPublisher(Just(.failed(requestError)))
            })
                .eraseToAnyPublisher()
    }
    
    private func displayPopupIfPreceed(_ requestError: RequestError) {
        switch requestError {
            case .commonError: sendPopupErrorNotification(model: .init(description: "Global error"))
            case .notInternet: sendPopupErrorNotification(model: .init(description: "No intenet connection"))
            case .timeout: sendPopupErrorNotification(model: .init(description: "Connection error (Time out)"))
            case .mapError(let requestData): tryToDecodeApiErrorResponse(requestData)
            default: break
        }
    }
    
    private func tryToDecodeApiErrorResponse(_ data: Data) {
        guard let latin1Data = String(data: data, encoding: .isoLatin1)?.data(using: .utf8),
              let errorModel = try? JSONDecoder().decode(RequestErrorModel.self, from: latin1Data) else {
            sendPopupErrorNotification(
                model: .init(
                    description: "Error. Please, try again in a few minutes or contact with us."
                )
            )
            return
        }
        
        sendPopupErrorNotification(model: .init(description: errorModel.errorUser))
    }
    
    private func sendPopupErrorNotification(model: ErrorPopupModel) {
        NotificationCenter.default.post(name: .displayErrorPopup, object: nil, userInfo: ["data": model])
    }
}
