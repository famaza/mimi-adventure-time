//
//  GameSceneStateMachineTwo.swift
//  Mimi
//
//  Created by Federico Maza on 10/2/17.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import GameplayKit

class GameStateMachine: GKStateMachine {
    unowned let gameScene: GameScene
        
    init(scene: GameScene) {
        self.gameScene = scene
		
		let activeState = ActiveState(for: gameScene)
        let beginState = BeginState(for: gameScene)
		let endState = EndState(for: gameScene)
        let pauseState = PauseState(for: gameScene)

        let states: [GKState] = [beginState, activeState, pauseState, endState]
        
        super.init(states: states)
    }
        
    override func update(deltaTime sec: TimeInterval) {
        if let currentState = currentState {
            currentState.update(deltaTime: sec)
        }
    }
}
