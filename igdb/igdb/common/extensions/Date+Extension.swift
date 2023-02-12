//
//  Date+Extension.swift
//  igdb
//
//  Created by Cristian Contreras on 9/2/23.
//

import Foundation

extension Date {
    func getOnlyDate() -> String {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "dd-MM-yyyy"
        return formatter1.string(from: self)
    }
}
