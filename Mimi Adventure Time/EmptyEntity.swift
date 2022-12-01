//
//  EmptyEntity.swift
//  Mimi
//
//  Created by Federico Maza on 26/01/2018.
//  Copyright © 2018 Federico Maza. All rights reserved.
//

import GameplayKit

class EmptyEntity: GKEntity {
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented.") }
}
