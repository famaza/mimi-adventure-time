//
//  GameScene.swift
//  Mimi
//
//  Created by Federico Maza on 10/2/17.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import GameplayKit

class GameScene: SKScene {
    lazy var stateMachine = GameStateMachine(scene: self)
    lazy var entityManager = EntityManager(scene: self)
        
    override init(size: CGSize) { super.init(size: size) }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented.") }

    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        physicsWorld.contactDelegate = self
    }
    
    override func didMove(to view: SKView) {
        stateMachine.enter(BeginState.self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        if stateMachine.canEnterState(ActiveState.self) {
            stateMachine.enter(ActiveState.self)
            
            return
        }
        
        let location = touch.location(in: self)
        
        if stateMachine.canEnterState(BeginState.self) {
            if let entity = atPoint(location).entity {
                if let identity = entity.component(ofType: IdentityComponent.self) {
                    switch identity.name {
                        case .tryAgain: stateMachine.enter(BeginState.self)

                        case .goBack:
                            if let component = entity.component(ofType: SegueComponent.self){
                                component.segue()
                            }
                        
                        default: break
                    }
                }
            }
        }
        
        if let currentState = stateMachine.currentState {
            if currentState is ActiveState {
                if let character = entityManager.get(entityNamed: .character), let component = character.component(ofType: MovementComponent.self) {
                    component.move()
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        stateMachine.update(deltaTime: currentTime)
    }
        
    func rebuild() {
        removeAllActions()
        removeAllChildren()
        
        entityManager.removeAllEntities()
        build()
    }
    
    func build() {
        presetEntities()
        
        if stateMachine.canEnterState(PauseState.self) {
            stateMachine.enter(PauseState.self)
        }
    }
    
    func start() {
        self.speed = 1
        self.physicsWorld.speed = 1
    }
    
    func stop() {
        self.speed = 0
        self.physicsWorld.speed = 0
    }
    
    private func presetEntities() {
        var background: SpriteEntity {
            let positionX = (frame.width / 2)
            let positionY = (frame.height / 2)
            let point = CGPoint(x: positionX, y: positionY)
            
            let position = Position(category: .background, point: point)
            let imageName = ImageName.GameScene.background
            let background = SpriteEntity(imageName: imageName, position: position)

            if let component = background.component(ofType: SpriteNodeComponent.self) {
                component.spriteNode.size = frame.size
            }

            return background
        }
        
        var character: CharacterEntity {
            let positionX = frame.midX
            let positionY = frame.midY
            let point = CGPoint(x: positionX, y: positionY)
            
            let position = Position(category: .character, point: point)
            let imageName = ImageName.Mimi.Classic.standing
            let character = CharacterEntity(imageName: imageName, position: position, entityManager: self.entityManager)
            
            return character
        }
        
        var ground: GroundEntity {
            let positionX = frame.midX
            let positionY = CGFloat(0)
            let point = CGPoint(x: positionX, y: positionY)
			
            let position = Position(category: .ground, point: point)
            let imageName = ImageName.GameScene.ground
            let ground = GroundEntity(imageName: imageName, position: position)

            return ground
        }
        
        let generator = GeneratorEntity(scene: self)
        let map = MapEntity(scene: self)
        let scoreboard = ScoreboardEntity(scene: self)

        entityManager.add(background)
        entityManager.add(map)
        entityManager.add(ground)
        entityManager.add(scoreboard)
        entityManager.add(generator)
        entityManager.add(character)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let physicsCategoryA = PhysicsCategory(rawValue: contact.bodyA.categoryBitMask)
        let physicsCategoryB = PhysicsCategory(rawValue: contact.bodyB.categoryBitMask)
        let shouldCallbackNodeAOnContact = physicsCategoryA.shouldCallbackOnContact(with: physicsCategoryB)
        let shouldCallbackNodeBOnContact = physicsCategoryB.shouldCallbackOnContact(with: physicsCategoryA)
        
        if shouldCallbackNodeAOnContact {
            if let nodeA = contact.bodyA.node, let entityA = nodeA.entity, let contactable = entityA as? Contactable {
                if let nodeB = contact.bodyB.node {
                    contactable.handleContact(with: nodeB)
                }
            }
        }
        
        if shouldCallbackNodeBOnContact {
            if let nodeB = contact.bodyB.node, let entityB = nodeB.entity, let contactable = entityB as? Contactable {
                if let nodeA = contact.bodyA.node {
                    contactable.handleContact(with: nodeA)
                }
            }
        }
    }
}
