//
//  igdbApp.swift
//  igdb
//
//  Created by Cristian Contreras on 8/2/23.
//

import SwiftUI

@main
struct igdbApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            AppDelegate.instance
                .getViewController(HomeViewController.self)
        }
    }
}
