//
//  Constans.swift
//  dtiOurense
//
//  Created by Cristian Contreras on 6/2/23.
//

import Foundation

// Develop enviroment
#if DEVELOPMENT
let base_url = "https://api.igdb.com/"
let api_app = "v4/"
#else
let base_url = "https://api.igdb.com/"
let api_app = "v4/"
#endif
let client_id = "ikefu3gjaojsnnt21ik7orxyofnztq"
let bearer_token = "Bearer"
let CFBundleShortVersionString = "CFBundleShortVersionString"
var appVersion: String {
    get {
        Bundle.main.object(forInfoDictionaryKey: CFBundleShortVersionString) as? String ?? "0"
    }
}
var appBuild: String {
    get {
        Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String ?? "0"
    }
}
var appBundler: String {
    get {
        Bundle.main.bundleIdentifier ?? "UNKNOWED_BUNDLER"
    }
}
