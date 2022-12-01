//
//  SpriteNodeComponent.swift
//  Mimi
//
//  Created by Federico Maza on 9/10/17.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import GameplayKit

class SpriteNodeComponent: GKComponent {
    let spriteNode: SKSpriteNode
        
    init(imageName: String) {
        let spriteNode = SKSpriteNode(imageNamed: imageName)
        
        self.spriteNode = spriteNode
        
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented.") }
        
    override func didAddToEntity() {
        spriteNode.entity = entity
    }

    override func willRemoveFromEntity() {
        spriteNode.entity = nil
    }
}
