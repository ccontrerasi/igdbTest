//
//  Preferences.swift
//
//
//  Created by Cristian Contreras on 2/2/23.
//

import Foundation

class Preferences {
    
    class func showWelcome() -> Bool {
        guard let welcome = UserDefaults.standard.object(forKey: "welcome") as? Bool else { return true }
        return welcome
    }
    
    class func showWelcome(_ welcome : Bool){
        UserDefaults.standard.set(welcome, forKey: "welcome")
    }
}
