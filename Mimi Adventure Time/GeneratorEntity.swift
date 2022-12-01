//
//  ObstacleGeneratorEntity.swift
//  Mimi
//
//  Created by Federico Maza on 01/01/2018.
//  Copyright © 2018 Federico Maza. All rights reserved.
//

import GameplayKit

class GeneratorEntity: GKEntity {
    var lastUpdateTime: Double
    var elapsedTimeSinceLastGeneration: TimeInterval
    var isEnabled: Bool
    
    lazy var obstacles = Set<ObstacleEntity>()
    
    let durationBetweenGeneration: Double
    let movementSpeedFactor: Double
    
    unowned let gameScene: GameScene
        
    init(scene: GameScene) {
        self.lastUpdateTime = 0
        self.elapsedTimeSinceLastGeneration = 0
        self.durationBetweenGeneration = GameConstants.durationBetweenObstacleGeneration
        self.movementSpeedFactor = GameConstants.obstacleMovementSpeedFactor
        self.isEnabled = true
        self.gameScene = scene
        
        super.init()
        
        presetComponents()
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented.") }
        
    override func update(deltaTime seconds: TimeInterval) {
        if isEnabled {
            let thetaTime: TimeInterval = seconds - lastUpdateTime
            
            lastUpdateTime = seconds
            elapsedTimeSinceLastGeneration = elapsedTimeSinceLastGeneration + thetaTime
            
            if elapsedTimeSinceLastGeneration > durationBetweenGeneration {
                let obstacle = makeObstacle()
                let action = makeAction(for: obstacle)
                
                if let nodeComponent = obstacle.component(ofType: NodeComponent.self), let action = action {
                    nodeComponent.node.run(action)
                }
                
                obstacles.insert(obstacle)
                gameScene.entityManager.add(obstacle)
                elapsedTimeSinceLastGeneration = 0
            }
        }
    }
        
    func stopObstacles() {
        for obstacle in obstacles {
            if let component = obstacle.component(ofType: NodeComponent.self) {
                component.node.removeAllActions()
            }
        }
        
        isEnabled = false
    }
        
    private func presetComponents() {
        let identityComponent = IdentityComponent(name: .generator)
        addComponent(identityComponent)
    }
    
    private func makeObstacle() -> ObstacleEntity {
        let character = gameScene.entityManager.get(entityNamed: .character)
        
        var gap = CGFloat(0)
        
        if let character = character, let spriteComponent = character.component(ofType: SpriteNodeComponent.self), let texture = spriteComponent.spriteNode.texture {
            gap = texture.size().height * 3.5
        }
        
		let obstaclePosition = Position(category: .obstacle, point: CGPoint(x: gameScene.frame.width + 50, y: gameScene.frame.height / 2))
        let obstacle = ObstacleEntity(imageName: ImageName.GameScene.obstacle, position: obstaclePosition, gap: gap)
        
        return obstacle
    }
    
    private func makeAction(for obstacle: ObstacleEntity) -> SKAction? {
        let distance = CGFloat(gameScene.frame.width + 100)
        
        // Set up the duration during, while the obstacle should be moving through, a calculation between a movement speed factor and the distance the obstacle should move. The higher the movement speed factor the slowest the movement speed.
        let duration = TimeInterval(movementSpeedFactor * Double(distance))
        let move = SKAction.moveBy(x: -(distance) , y: 0, duration: duration)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([move, remove])
        
        return sequence
    }
}
