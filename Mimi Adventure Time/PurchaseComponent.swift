//
//  PurchaseComponent.swift
//  Mimi
//
//  Created by Federico Maza on 24/01/2018.
//  Copyright © 2018 Federico Maza. All rights reserved.
//

import GameplayKit

class PurchaseComponent: GKComponent {
    
    // MARK: Properties
    
    let product: InAppPurchaseProduct
    
    // MARK: Initialization
    
    init(product: InAppPurchaseProduct) {
        
        self.product = product
        
        super.init()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented.")
        
    }
    
    // MARK: Methods
    
    func purchase() {
        
        InAppPurchaseManager.shared.purchase(product: product)
        
    }
    
}
