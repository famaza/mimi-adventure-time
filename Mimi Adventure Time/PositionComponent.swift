//
//  PositionComponent.swift
//  Mimi
//
//  Created by Federico Maza on 10/3/17.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import GameplayKit

class PositionComponent: GKComponent {
    let point: CGPoint
    let zPosition: CGFloat
        
    init(node spriteNode: SKSpriteNode, position: Position) {
        self.point = position.point
        self.zPosition = position.category.asCGFloat
        
        super.init()
        
        place(spriteNode, at: self.point, with: self.zPosition)
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented.") }
        
    private func place(_ spriteNode: SKSpriteNode, at point: CGPoint, with zPosition: CGFloat) {
        spriteNode.position = point
        spriteNode.zPosition = zPosition
    }
}
