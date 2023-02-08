//
//  Constans.swift
//  dtiOurense
//
//  Created by Cristian Contreras on 6/2/23.
//

import Foundation

// Develop enviroment
#if DEVELOPMENT
let base_url = "https://gateway.marvel.com/"
let api_app = "v1/public/"
#else
let base_url = "https://gateway.marvel.com/"
let api_app = "v1/public/"
#endif
let client_id = "ikefu3gjaojsnnt21ik7orxyofnztq"
let bearer_token = "b9b8twp1it10ilyuf6r7n8ajw4tlzz"
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
