//
//  ActiveStateTwo.swift
//  Mimi
//
//  Created by Federico Maza on 6/5/17.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import Foundation
import GameplayKit

class ActiveState: GKState {
    unowned let gameScene: GameScene
        
    init(for scene: GameScene) {
        self.gameScene = scene
        
        super.init()
    }
        
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
            case is PauseState.Type: return true
            case is EndState.Type: return true
            
            default: return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        gameScene.isPaused = false
    }
    
    override func update(deltaTime: TimeInterval) {
        gameScene.entityManager.update(deltaTime)
    }
}
