//
//  SegueComponent.swift
//  Mimi
//
//  Created by Federico Maza on 11/6/17.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import GameplayKit

class SegueComponent: GKComponent {
    let scene: SKScene
    let view: SKView
    let debugging: Bool
        
    init(scene: SKScene, view: SKView, debugging: Bool) {
        self.scene = scene
        self.view = view
        self.debugging = debugging
        
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented.") }
        
    func segue() {
        scene.scaleMode = .aspectFill
        
        if debugging {
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
            view.presentScene(scene)
        } else {
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
            view.showsPhysics = false
            view.presentScene(scene)
        }
    }
}
