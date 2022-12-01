//
//  ApplicationDelegate.swift
//  Mimi
//
//  Created by Federico Maza on 1/16/17.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import UIKit

@UIApplicationMain

class ApplicationDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AtlasManager.shared
        SoundManager.shared
        FontManager.shared
        DataManager.shared
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window = window {
            window.rootViewController = UINavigationController(rootViewController: GameViewController())
            window.makeKeyAndVisible()
        }
        
        return true
    }
}
