//
//  EntityManager.swift
//  Mimi
//
//  Created by Federico Maza on 24/12/2017.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import GameplayKit

class EntityManager {
    lazy var entities = Set<GKEntity>()
    lazy var entitiesGarbage = Set<GKEntity>()
    
    unowned let scene: SKScene
        
    init(scene: SKScene) {
        self.scene = scene
    }
        
    func add(_ entity: GKEntity) {
        if let nodeComponent = entity.component(ofType: NodeComponent.self) {
            scene.addChild(nodeComponent.node)
        }
        
        if let spriteComponent = entity.component(ofType: SpriteNodeComponent.self) {
            scene.addChild(spriteComponent.spriteNode)
        }
        
        if let labelComponent = entity.component(ofType: LabelNodeComponent.self) {
            scene.addChild(labelComponent.labelNode)
        }
        
        entities.insert(entity)
    }
    
    func remove(_ entity: GKEntity) {
        if let nodeComponent = entity.component(ofType: NodeComponent.self) {
            nodeComponent.node.removeFromParent()
        }
        
        if let spriteComponent = entity.component(ofType: SpriteNodeComponent.self) {
            spriteComponent.spriteNode.removeFromParent()
        }
        
        entitiesGarbage.insert(entity)
    }
    
    func update(_ deltaTime: CFTimeInterval) {
        for entity in entities {
            entity.update(deltaTime: deltaTime)
        }
        
        entitiesGarbage.removeAll()
    }
    
    func get(entityNamed: EntityName) -> GKEntity? {
        for entity in entities {
            if let identity = entity.component(ofType: IdentityComponent.self) {
                if identity.name.rawValue == entityNamed.rawValue {
                    return entity
                }
            }
        }
        
        return nil
    }
    
    func removeAllEntities() {
        entities = Set<GKEntity>()
        entitiesGarbage = Set<GKEntity>()
    }
}
