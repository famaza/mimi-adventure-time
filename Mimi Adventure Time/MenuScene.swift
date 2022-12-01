//
//  MenuScene.swift
//  Mimi
//
//  Created by Federico Maza on 5/27/17.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import GameplayKit

class MenuScene: SKScene {
    var canStartGame: Bool { return true }
    
    lazy var entityManager = EntityManager(scene: self)
    
    override init(size: CGSize) { super.init(size: size) }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented.") }
    
    override func didMove(to view: SKView) {
        presetEntities()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
                
        if let entity = atPoint(location).entity {
            if let identity = entity.component(ofType: IdentityComponent.self) {
                switch identity.name {
                    case .start:
                        if canStartGame {
                            if let component = entity.component(ofType: SegueComponent.self) {
                                run(SoundManager.shared.clickSound)

                                component.segue()
                            }
                        }
                    case .shop:
                        if let component = entity.component(ofType: SegueComponent.self) {
                            run(SoundManager.shared.clickSound)
                            
                            component.segue()
                        }
                    
                    default: break
                }
            }
        }
    }
        
    private func presetEntities() {
        var lastElementPosition = CGFloat(0)

        var background: SpriteEntity {
            let positionX = frame.midX
            let positionY = frame.midY
            let point = CGPoint(x: positionX, y: positionY)
			
            let position = Position(category: .background, point: point)
            let imageName = ImageName.MenuScene.background
            let background = SpriteEntity(imageName: imageName, position: position)
            
            if let component = background.component(ofType: SpriteNodeComponent.self) {
                component.spriteNode.size = frame.size
                component.spriteNode.zPosition = PositionCategory.background.asCGFloat
            }
            
            return background
        }
        
        var gameLogo: SpriteEntity {
            let positionX = frame.midX
            let positionY = frame.height
            let point = CGPoint(x: positionX, y: positionY)
			
            let position = Position(category: .interface, point: point)
            let imageName = ImageName.MenuScene.gameLogo
            let gameLogo = SpriteEntity(imageName: imageName, position: position)
            
            if let component = gameLogo.component(ofType: SpriteNodeComponent.self) {
                component.spriteNode.position.y = component.spriteNode.position.y - (component.spriteNode.frame.height)
                
                lastElementPosition = component.spriteNode.position.y
            }
            
            return gameLogo
        }
                
        var startButton: SpriteEntity {
            let positionX = frame.midX
            let positionY = frame.height
            let point = CGPoint(x: positionX, y: positionY)
			
            let position = Position(category: .interface, point: point)
            let imageName = ImageName.MenuScene.startButton
            let startButton = SpriteEntity(imageName: imageName, position: position)
            
            if let component = startButton.component(ofType: SpriteNodeComponent.self) {
                component.spriteNode.position.y = lastElementPosition - (component.spriteNode.frame.height * 3)
                
                lastElementPosition = component.spriteNode.position.y
            }
            
            let identity = IdentityComponent(name: .start)
            
            startButton.addComponent(identity)
            
            if let view = self.view {
                let scene = GameScene(size: size)
                let segue = SegueComponent(scene: scene, view: view, debugging: false)
                
                startButton.addComponent(segue)
            }
            
            return startButton
        }
        
        entityManager.add(background)
        entityManager.add(gameLogo)
        entityManager.add(startButton)
    }
}
