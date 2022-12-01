//
//  PreloadScene.swift
//  Mimi
//
//  Created by Federico Maza on 5/27/17.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import GameplayKit

class PreloadingScene: SKScene {
    override func didMove(to view: SKView) {
        AtlasManager.shared.textureAtlas.preload(completionHandler: {
            let menuScene = MenuScene(size: self.size)
            
            menuScene.scaleMode = .aspectFill
            
            if let view = self.view {
                view.presentScene(menuScene)
            }
        })
    }
}
