//
//  MovementComponent.swift
//  Mimi
//
//  Created by Federico Maza on 19/12/2017.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import GameplayKit

class MovementComponent: GKComponent {
    lazy var animation = SKAction()
    
    let spriteNode: SKSpriteNode
        
    init(node spriteNode: SKSpriteNode) {
        self.spriteNode = spriteNode
        
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented.") }
        
    override func didAddToEntity() {
        if let entity = entity, let component = entity.component(ofType: AnimationComponent.self) {
            self.animation = component.getAnimation(for: .movement)
        }
    }
    
    func move() {
        let impulse = CGVector(dx: 0, dy: GameConstants.characterMovementDeltaValue)
        
        if let physicsBody = spriteNode.physicsBody {
            physicsBody.applyImpulse(impulse)
        }
        
        spriteNode.run(animation)
                        
        if let entity = entity as? CharacterEntity {
            entity.entityManager.scene.run(SoundManager.shared.movementSound)
        }
    }
}
