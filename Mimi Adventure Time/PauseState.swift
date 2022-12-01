//
//  PauseStateTwo.swift
//  Mimi
//
//  Created by Federico Maza on 6/6/17.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import Foundation
import GameplayKit

class PauseState: GKState {
    unowned let gameScene: GameScene
        
    init(for scene: GameScene) {
        self.gameScene = scene
        
        super.init()
    }
        
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
            case is ActiveState.Type: return true
            
            default: return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        gameScene.isPaused = true
    }
}
