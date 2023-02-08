//
//  ApiServices.swift
//  dtiOurense
//
//  Created by Cristian Contreras on 6/2/23.
//

import Foundation
import Moya
import Alamofire

enum ApiServices {
    case fetchGames
}

extension ApiServices : TargetType {
    
    var baseURL: URL {
        switch self {
        default:
            return URL(string: base_url + api_app)!
        }
    }
    
    var path: String {
        switch self {
        case .fetchGames:
            return "games"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchGames:
            return .post
        }
    }
    
    var sampleData: Data {
        var result = ""
        switch self {
        case .fetchGames:
            result = "Called to fetchGames."
        }
        return result.utf8Encoded
    }
    
    var task: Task {
        switch self {
        case .fetchGames:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        get {
            ["content-type" : "application/json",
             "CLIENT-ID" : client_id,
             "Authorization" : bearer_token]
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}

struct VerbosePlugin: PluginType {
    let verbose: Bool
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
#if DEBUG
        let rq = "\(request.url?.absoluteString ?? "")"
        if let body = request.httpBody {
            if let str = String(data: body, encoding: .utf8) {
                print("request to url >>>>>> \(rq)?\(str)")
            } else {
                print("request to url >>>>>> \(rq)")
            }
        } else {
            print("request to url >>>>>> \(rq)")
        }
#endif
        return request
    }
}
