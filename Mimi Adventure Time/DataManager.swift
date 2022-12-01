//
//  DataManager.swift
//  Mimi
//
//  Created by Federico Maza on 28/12/2017.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import Foundation

class DataManager {
    var highscore: Int {
        get { return UserDefaults.standard.integer(forKey: StorageKey.highscore) }
        set(value) { UserDefaults.standard.set(value, forKey: StorageKey.highscore) }
    }
    
    static let shared = DataManager()
}
