//
//  NodeComponent.swift
//  Mimi
//
//  Created by Federico Maza on 28/12/2017.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import GameplayKit

class NodeComponent: GKComponent {
    let node: SKNode
        
    init(childs: [SKNode]) {
        let node = SKNode()
        
        for child in childs {
            node.addChild(child)
        }
        
        self.node = node
        
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented.") }
    
    override func didAddToEntity() {
        node.entity = entity
        
        for child in node.children {
            child.entity = entity
        }
    }

    override func willRemoveFromEntity() {
        node.entity = nil
        
        for child in node.children {
            child.entity = nil
        }
    }
}
