//
//  LabelNodeComponent.swift
//  Mimi
//
//  Created by Federico Maza on 11/02/2018.
//  Copyright © 2018 Federico Maza. All rights reserved.
//

import GameplayKit

class LabelNodeComponent: GKComponent {
    let labelNode: SKLabelNode
        
    init(text: String) {
        let font = FontManager.shared.informationFont
        let labelNode = SKLabelNode(fontNamed: font.fontName)
        
        labelNode.fontSize = 10
        labelNode.text = text
                
        self.labelNode = labelNode
        
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented.") }
        
    override func didAddToEntity() {
        labelNode.entity = entity
    }
    
    override func willRemoveFromEntity() {
        labelNode.entity = nil
    }
    
}
