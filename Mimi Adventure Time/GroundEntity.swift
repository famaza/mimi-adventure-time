//
//  GroundEntity.swift
//  Mimi
//
//  Created by Federico Maza on 19/12/2017.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import GameplayKit

class GroundEntity: GKEntity {
    init(imageName: String, position: Position) {
        super.init()
        
        presetComponents(imageName: imageName, position: position)
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented.") }
        
    private func presetComponents(imageName: String, position: Position) {
        let spriteComponent = SpriteNodeComponent(imageName: imageName)

        let physicsBodyComponent = PhysicsBodyComponent(node: spriteComponent.spriteNode, imageName: imageName, category: .ground)
        let positionComponent = PositionComponent(node: spriteComponent.spriteNode, position: position)

        addComponent(spriteComponent)
        addComponent(physicsBodyComponent)
        addComponent(positionComponent)
    }
}
