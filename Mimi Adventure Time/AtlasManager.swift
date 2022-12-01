//
//  AtlasManager.swift
//  Mimi
//
//  Created by Federico Maza on 22/12/2017.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import GameplayKit

class AtlasManager {
    let textureAtlas: SKTextureAtlas
        
    static let shared = AtlasManager(atlasName: AtlasName.globalAtlas)
        
    private init(atlasName: String) {
        self.textureAtlas = SKTextureAtlas(named: atlasName)
    }
}
