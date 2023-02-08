//
//  String+Extensions.swift
//  marvelExample
//
//  Created by Cristian Contreras on 2/2/23.
//

import Foundation

extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
