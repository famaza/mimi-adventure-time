//
//  AnimationComponent.swift
//  Mimi
//
//  Created by Federico Maza on 26/12/2017.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import GameplayKit

class AnimationComponent: GKComponent {
    var animations: [AnimationCategory: [SKTexture]]
        
    init(animations: [AnimationCategory: [String]]) {
        self.animations = [:]
        
        for (key, value) in animations {
            var textures: [SKTexture] = []
            
            for image in value {
                let texture = AtlasManager.shared.textureAtlas.textureNamed(image)
                textures.append(texture)
            }
            
            self.animations[key] = textures
        }
        
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented.") }
        
    func getAnimation(for category: AnimationCategory) -> SKAction {
        var animation = SKAction()

        let timePerFrame: TimeInterval = (12 / 60)
        
        if let textures = animations[category] {
            animation = SKAction.animate(with: textures, timePerFrame: timePerFrame)
            
            return animation
        }
        
        return animation
    }
}
