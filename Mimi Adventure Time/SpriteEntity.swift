//
//  InterfaceEntity.swift
//  Mimi
//
//  Created by Federico Maza on 11/3/17.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import GameplayKit

class SpriteEntity: GKEntity {
    init(imageName: String, position: Position) {
        super.init()
        
        presetComponents(imageName: imageName, position: position)
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented.") }
        
    private func presetComponents(imageName: String, position: Position) {
        let spriteComponent = SpriteNodeComponent(imageName: imageName)
        let positionComponent = PositionComponent(node: spriteComponent.spriteNode, position: position)

        addComponent(spriteComponent)
        addComponent(positionComponent)
    }
}
