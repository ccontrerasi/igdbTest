//
//  RequestError.swift
//  dtiOurense
//
//  Created by Cristian Contreras on 6/2/23.
//

import Foundation

enum RequestError: Error, Equatable {
    case commonError
    case notInternet
    case timeout
    case incorrectURL
    case dataEmpty
    case mapError(Data)
    case managersHerency
}

struct RequestErrorModel: Decodable {
    let errorCode: Int
    let errorDes: String
    let errorUser: String
}
