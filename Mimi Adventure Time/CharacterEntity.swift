//
//  CharacterEntity.swift
//  Mimi
//
//  Created by Federico Maza on 9/10/17.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import GameplayKit

class CharacterEntity: GKEntity {
    unowned let entityManager: EntityManager
        
    init(imageName: String, position: Position, entityManager: EntityManager) {
        self.entityManager = entityManager
        
        super.init()
                
        presetComponents(imageName: imageName, position: position)
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented.") }
        
    override func update(deltaTime seconds: TimeInterval) {
		// TODO: Program update behaviour.
    }
        
    private func presetComponents(imageName: String, position: Position) {
        let identityComponent = IdentityComponent(name: .character)
        let spriteComponent = SpriteNodeComponent(imageName: imageName)
        
        addComponent(identityComponent)
        addComponent(spriteComponent)
        
        var collisionImages: [String] = []
        var dictionary: [AnimationCategory: [String]] = [:]
        var movementImages: [String] = []
        
        collisionImages.append(ImageName.Particle.Explosion.first)
        collisionImages.append(ImageName.Particle.Explosion.second)
        collisionImages.append(ImageName.Particle.Explosion.third)
        collisionImages.append(ImageName.Particle.Explosion.fourth)
        collisionImages.append(ImageName.Particle.Explosion.fifth)
        collisionImages.append(ImageName.Particle.Explosion.sixth)
        
        movementImages.append(ImageName.Mimi.Classic.jumping)
        movementImages.append(ImageName.Mimi.Classic.standing)
		movementImages.append(ImageName.Mimi.Classic.walking)

        dictionary[.collision] = collisionImages
        dictionary[.movement] = movementImages

        let animationComponent = AnimationComponent(animations: dictionary)
        let movementComponent = MovementComponent(node: spriteComponent.spriteNode)
        let physicsBodyComponent = PhysicsBodyComponent(node: spriteComponent.spriteNode, imageName: imageName, category: .character)
        let positionComponent = PositionComponent(node: spriteComponent.spriteNode, position: position)
        
        addComponent(animationComponent)
        addComponent(movementComponent)
        addComponent(physicsBodyComponent)
        addComponent(positionComponent)
    }
}

extension CharacterEntity: Contactable {
    func handleContact(with node: SKNode) {
        if let physicsBody = node.physicsBody {
            if PhysicsCategory(rawValue: physicsBody.categoryBitMask).contains(.obstacle) {
                handleContactWithObstacleOrGround()
            }
            
            if PhysicsCategory(rawValue: physicsBody.categoryBitMask).contains(.ground) {
                handleContactWithObstacleOrGround()
            }
            
            if PhysicsCategory(rawValue: physicsBody.categoryBitMask).contains(.prize) {
                handleContactWithPrize(node: node)
            }
        }
    }
        
    private func handleContactWithObstacleOrGround() {
        self.removeComponent(ofType: MovementComponent.self)
        
        self.removeComponent(ofType: PhysicsBodyComponent.self)
        
        if let generator = self.entityManager.get(entityNamed: .generator) as? GeneratorEntity {
            generator.stopObstacles()
        }
        
        if let spriteComponent = self.component(ofType: SpriteNodeComponent.self) {
            if let animationComponent = self.component(ofType: AnimationComponent.self) {
                spriteComponent.spriteNode.run(animationComponent.getAnimation(for: .collision), completion: {
                    self.entityManager.remove(self)
                    
                    // TODO: Should not be the responsability of this entity to triggers a state in the scene's state machine.
                    
                    if let gameScene = self.entityManager.scene as? GameScene {
                        let stateMachine = gameScene.stateMachine
                        
                        if stateMachine.canEnterState(EndState.self) {
                            stateMachine.enter(EndState.self)
                        }
                    }
                })
            }
        }
    }
    
    private func handleContactWithPrize(node: SKNode) {
        if let physicsBody = node.physicsBody {
            physicsBody.categoryBitMask = 0
        }
        
        node.removeFromParent()
        
        if let scoreboard = entityManager.get(entityNamed: .scoreboard) as? ScoreboardEntity {
            let score = scoreboard.score + 1
            scoreboard.update(score: score)
        }
                
        if let gameScene = self.entityManager.scene as? GameScene {
            gameScene.run(SoundManager.shared.collectionSound)
        }
    }
}
