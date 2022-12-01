//
//  IdentityComponent.swift
//  Mimi
//
//  Created by Federico Maza on 08/01/2018.
//  Copyright © 2018 Federico Maza. All rights reserved.
//

import GameplayKit

class IdentityComponent: GKComponent {
    let name: EntityName
        
    init(name: EntityName) {
        self.name = name
        
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented.") }
}
