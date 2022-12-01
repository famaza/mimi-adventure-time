//
//  PhysicsBodyComponent.swift
//  Mimi
//
//  Created by Federico Maza on 9/30/17.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import GameplayKit

class PhysicsBodyComponent: GKComponent {
    let physicsBody: SKPhysicsBody
        
    init(node spriteNode: SKSpriteNode, imageName: String, category: PhysicsCategory) {
        let texture = SKTexture(imageNamed: imageName)
        let physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        
        self.physicsBody = physicsBody
        self.physicsBody.categoryBitMask = category.categoryBitMask
        self.physicsBody.collisionBitMask = category.collisionBitMask
        self.physicsBody.contactTestBitMask = category.contactTestBitMask
        self.physicsBody.affectedByGravity = category.affectedByGravity
        self.physicsBody.isDynamic = category.isDynamic
        self.physicsBody.allowsRotation = category.allowsRotation
        
        self.physicsBody.usesPreciseCollisionDetection = true
        
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented.") }
        
    override func didAddToEntity() {
        if let entity = entity, let component = entity.component(ofType: SpriteNodeComponent.self) {
            component.spriteNode.physicsBody = physicsBody
        }
    }
    
    override func willRemoveFromEntity() {
        if let entity = entity, let component = entity.component(ofType: SpriteNodeComponent.self) {
            component.spriteNode.physicsBody = nil
        }
    }
}
