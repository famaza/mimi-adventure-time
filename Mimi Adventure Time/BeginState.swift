//
//  StartStateTwo.swift
//  Mimi
//
//  Created by Federico Maza on 6/5/17.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import Foundation
import GameplayKit

class BeginState: GKState {
    unowned let gameScene: GameScene
        
    init(for scene: GameScene) {
        self.gameScene = scene
        
        super.init()
    }
        
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is PauseState.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        switch previousState {
            case is EndState:
                gameScene.start()
                gameScene.rebuild()
            
            default:
                gameScene.start()
                gameScene.build()
        }
    }
}
