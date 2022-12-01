//
//  GameViewController.swift
//  Mimi
//
//  Created by Federico Maza on 1/16/17.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigationController = navigationController {
            navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.isTranslucent = true
        }
        
        let gameView = SKView(frame: view.frame)
        let preloadingScene = PreloadingScene(size: view.bounds.size)
        
        preloadingScene.scaleMode = .aspectFill
        gameView.presentScene(preloadingScene)
                
        view.addSubview(gameView)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
