//
//  AppDelegate.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 12.09.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            let navigationVC = UINavigationController()
            window.rootViewController = navigationVC
            window.makeKeyAndVisible()
            Navigator.shared.show(segue: .newMovies, sender: navigationVC)
        }
        
        return true
    }
}

