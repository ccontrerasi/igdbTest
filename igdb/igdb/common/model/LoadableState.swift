//
//  LoadableState.swift
//  dtiOurense
//
//  Created by Cristian Contreras on 6/2/23.
//

import Combine

enum LoadableState<Value> {
    case idle
    case loading
    case failed(RequestError)
    case result(Value)
    
    func getResult() -> Value? {
        guard case let .result(value) = self else { return nil }
        
        return value
    }
    
    func getError() -> RequestError? {
        guard case let .failed(error) = self else { return nil }
        
        return error
    }
}

extension LoadableState: Equatable {
    
    static func == (lhs: LoadableState<Value>, rhs: LoadableState<Value>) -> Bool {
        switch (lhs, rhs) {
            case (.idle, .idle): return true
            case (.loading, .loading): return true
            case (.result(_), .result(_)): return true
            case (.failed(_), .failed(_)): return true
                
            case (.idle, .loading): return false
            case (.idle, .failed(_)): return false
            case (.idle, .result(_)): return false
                
            case (.loading, .idle): return false
            case (.loading, .failed(_)): return false
            case (.loading, .result(_)): return false
                
            case (.failed(_), .idle): return false
            case (.failed(_), .loading): return false
            case (.failed(_), .result(_)): return false
                
            case (.result(_), .idle): return false
            case (.result(_), .loading): return false
            case (.result(_), .failed(_)): return false
        }
    }
}
