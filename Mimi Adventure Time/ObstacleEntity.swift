//
//  ObstacleEntity.swift
//  Mimi
//
//  Created by Federico Maza on 28/12/2017.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import GameplayKit

class ObstacleEntity: GKEntity {
    init(imageName: String, position: Position, gap: CGFloat) {
        super.init()
        
        presetComponents(imageName: imageName, position: position, gap: gap)
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented.") }
        
    private func presetComponents(imageName: String, position: Position, gap: CGFloat) {
        let topNode = makeObstacleSprite(imageName: imageName, position: position)
        let bottomNode = makeObstacleSprite(imageName: imageName, position: position)
        let centerNode = makePrizeSprite(position: position)

        topNode.position.y = topNode.position.y + gap
        bottomNode.position.y = bottomNode.position.y - gap
        
        let childNodes = [topNode, bottomNode, centerNode]
        let nodeComponent = NodeComponent(childs: childNodes)
        let randomMethod = GKRandomSource()
        let variationValue = Int(gap / 4)
        let randomDistribution = GKGaussianDistribution(randomSource: randomMethod, lowestValue: -variationValue, highestValue: variationValue)
        let randomNumber = randomDistribution.nextInt()
        
        nodeComponent.node.position.y = nodeComponent.node.position.y + CGFloat(randomNumber)
        
        addComponent(nodeComponent)
    }
        
    private func makeObstacleSprite(imageName: String, position: Position) -> SKSpriteNode {
        let spriteNode = SKSpriteNode(imageNamed: imageName)
        
        spriteNode.position = position.point
        spriteNode.zPosition = position.category.asCGFloat
        
        let texture = SKTexture(imageNamed: imageName)
        let physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        let physicsCategory: PhysicsCategory = .obstacle
        
        physicsBody.categoryBitMask = physicsCategory.categoryBitMask
        physicsBody.collisionBitMask = physicsCategory.collisionBitMask
        physicsBody.contactTestBitMask = physicsCategory.contactTestBitMask
		physicsBody.affectedByGravity = physicsCategory.affectedByGravity
        physicsBody.isDynamic = physicsCategory.isDynamic
        physicsBody.usesPreciseCollisionDetection = true
        
        spriteNode.physicsBody = physicsBody
        
        return spriteNode
    }
    
    private func makePrizeSprite(position: Position) ->  SKSpriteNode {
        let index: Int = GKRandomSource.sharedRandom().nextInt(upperBound: PrizeCollection.availablePrizes.endIndex)
        let prize: PrizeType = PrizeCollection.availablePrizes[index]
        let spriteNode = SKSpriteNode(imageNamed: prize.rawValue)
        
        spriteNode.position = position.point
        spriteNode.zPosition = position.category.asCGFloat
        
        let texture = SKTexture(imageNamed: prize.rawValue)
        let physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        let physicsCategory: PhysicsCategory = .prize
        
        physicsBody.categoryBitMask = physicsCategory.categoryBitMask
        physicsBody.collisionBitMask = physicsCategory.collisionBitMask
        physicsBody.contactTestBitMask = physicsCategory.contactTestBitMask
        physicsBody.affectedByGravity = physicsCategory.affectedByGravity
        physicsBody.isDynamic = physicsCategory.isDynamic
        physicsBody.usesPreciseCollisionDetection = true
        
        spriteNode.physicsBody = physicsBody
        
        return spriteNode
    }
}
