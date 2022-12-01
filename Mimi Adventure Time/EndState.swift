//
//  EndStateTwo.swift
//  Mimi
//
//  Created by Federico Maza on 6/5/17.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import Foundation
import GameplayKit

class EndState: GKState {
    unowned let gameScene: GameScene
        
    init(for scene: GameScene) {
        self.gameScene = scene
        
        super.init()
    }
        
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
            case is BeginState.Type: return true
            
            default: return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        gameScene.stop()
        askForRetry()
        askIfWantToGoBack()
    }
        
    private func askForRetry() {
        var button: SpriteEntity {
            let positionX = gameScene.frame.midX
            let positionY = gameScene.frame.midY
            let point = CGPoint(x: positionX, y: positionY)
            
			let position = Position(category: .interface, point: point)
            let imageName = ImageName.GameScene.goAgain
            let button = SpriteEntity(imageName: imageName, position: position)
            
            if let component = button.component(ofType: SpriteNodeComponent.self) {
                component.spriteNode.position.y = component.spriteNode.position.y + (component.spriteNode.frame.width / 2)
            }
            
            let identity = IdentityComponent(name: .tryAgain)
            
            button.addComponent(identity)
            
            return button
        }
        
        gameScene.entityManager.add(button)
    }
    
    private func askIfWantToGoBack() {
        var button: SpriteEntity {
            let positionX = gameScene.frame.midX
            let positionY = gameScene.frame.midY
            let point = CGPoint(x: positionX, y: positionY)
			
            let position = Position(category: .interface, point: point)
            let imageName = ImageName.GameScene.goBack
            let button = SpriteEntity(imageName: imageName, position: position)
            
            if let component = button.component(ofType: SpriteNodeComponent.self) {
                component.spriteNode.position.y = component.spriteNode.position.y - (component.spriteNode.frame.width / 2)
            }
            
            let identity = IdentityComponent(name: .goBack)
           
            button.addComponent(identity)
            
            if let view = gameScene.view {
                let scene = MenuScene(size: view.frame.size)
                let segue = SegueComponent(scene: scene, view: view, debugging: false)
                
                button.addComponent(segue)
            }
            
            return button
        }
        
        gameScene.entityManager.add(button)
    }
}
