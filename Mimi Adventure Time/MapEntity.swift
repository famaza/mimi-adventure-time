//
//  SceneMapEntity.swift
//  Mimi
//
//  Created by Federico Maza on 24/4/18.
//  Copyright © 2018 Federico Maza. All rights reserved.
//

import GameplayKit

class MapEntity: GKEntity {
    let background: SKSpriteNode
    let foreground: SKSpriteNode
    
    unowned let gameScene: SKScene
        
    init(scene: SKScene) {
        self.gameScene = scene
        self.background = SKSpriteNode(imageNamed: ImageName.GameScene.city)
        self.foreground = SKSpriteNode(imageNamed: ImageName.GameScene.park)
        
        super.init()
        
        self.configureLandscape()
        self.configurePresetComponents()
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented.") }
    
    private func configureBackground() {
        let positionX = gameScene.frame.minX
        let positionY = gameScene.frame.minY
        let point = CGPoint(x: positionX, y: positionY)
        
        self.background.position = point
        self.background.zPosition = NodeOrder.background
        self.background.size.height = gameScene.frame.size.height
        self.background.anchorPoint = CGPoint.zero
        
        if let texture = self.background.texture {
            let factor = CGFloat(GameConstants.backgroundMovementSpeedFactor)
            let duration = TimeInterval(factor * texture.size().width)
            let move = SKAction.moveBy(x: -(texture.size().width), y: 0, duration: duration)
            let relocate = SKAction.moveBy(x: texture.size().width, y: 0, duration: 0.0)
            let sequence = SKAction.sequence([move, relocate])
            let loop = SKAction.repeatForever(sequence)
            
            self.background.run(loop)
        }
    }
    
    private func configureForeground() {
        let positionX = gameScene.frame.minX
        let positionY = gameScene.frame.minY
        let point = CGPoint(x: positionX, y: positionY)
        
        self.foreground.position = point
        self.foreground.zPosition = NodeOrder.foreground
        self.foreground.size.height = gameScene.frame.size.height
        self.foreground.anchorPoint = CGPoint.zero
        
        if let texture = self.foreground.texture {
            let factor = CGFloat(GameConstants.foregroundMovementSpeedFactor)
            let duration = TimeInterval(factor * texture.size().width)
            let move = SKAction.moveBy(x: -(texture.size().width), y: 0, duration: duration)
            let relocate = SKAction.moveBy(x: texture.size().width, y: 0, duration: 0.0)
            let sequence = SKAction.sequence([move, relocate])
            let loop = SKAction.repeatForever(sequence)
            
            self.foreground.run(loop)
        }
    }
    
    private func configureLandscape() {
        self.configureBackground()
        self.configureForeground()
    }
    
    private func configurePresetComponents() {
        let nodeComponent = NodeComponent(childs: [self.background, self.foreground])
        
        addComponent(nodeComponent)
    }
}
