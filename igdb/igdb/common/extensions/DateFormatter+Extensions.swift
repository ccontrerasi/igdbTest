//
//  DateFormatter+Extensions.swift
//
//  Created by Cristian Contreras on 2/2/23.
//

import Foundation

extension DateFormatter {
    static let dateFromServerFull: DateFormatter = {
        let formatter = DateFormatter()
        //2014-04-29T14:18:17-0400
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()
}
