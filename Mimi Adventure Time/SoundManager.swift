//
//  SoundManager.swift
//  Mimi
//
//  Created by Federico Maza on 10/01/2018.
//  Copyright © 2018 Federico Maza. All rights reserved.
//

import GameplayKit

class SoundManager {
    let movementSound: SKAction
    let collectionSound: SKAction
    let clickSound: SKAction
        
    static let shared = SoundManager()
        
    private init() {
        let movementSound = SKAction.playSoundFileNamed(SoundName.jump, waitForCompletion: false)
        let collectionSound = SKAction.playSoundFileNamed(SoundName.collect, waitForCompletion: false)
        let clickSound = SKAction.playSoundFileNamed(SoundName.click, waitForCompletion: false)

        self.movementSound = movementSound
        self.collectionSound = collectionSound
        self.clickSound = clickSound
    }
}
