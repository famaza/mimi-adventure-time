//
//  PhysicsCategory.swift
//  Mimi
//
//  Created by Federico Maza on 23/12/2017.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import Foundation

struct PhysicsCategory: OptionSet {
    var categoryBitMask: UInt32 { return rawValue }
    
    var collisionBitMask: UInt32 {
        if let definedCollisions = PhysicsCategory.definedCollisions[self] {
            let mask = definedCollisions.reduce(PhysicsCategory()) { (initial, physicsCategory) in return initial.union(physicsCategory) }
            
            return mask.rawValue
        }
        
        return 0
    }
    
    var contactTestBitMask: UInt32 {
        if let callbackOnContact = PhysicsCategory.callbackOnContact[self] {
            let mask = callbackOnContact.reduce(PhysicsCategory()) { (initial, physicsCategory) in return initial.union(physicsCategory) }
            
            return mask.rawValue
        }
        
        return 0
    }
    
    var affectedByGravity: Bool { return PhysicsCategory.gravityAffectedCategories.contains(self) }
    var isDynamic: Bool { return PhysicsCategory.dynamicCategories.contains(self) }
    var allowsRotation: Bool { return PhysicsCategory.allowedRotationCategories.contains(self) }

    static var definedCollisions: [PhysicsCategory: [PhysicsCategory]] {
        var definedCollisions: [PhysicsCategory: [PhysicsCategory]] = [:]
        definedCollisions[.character] = [.obstacle, .ground]
        
        return definedCollisions
    }
    
    static var callbackOnContact: [PhysicsCategory: [PhysicsCategory]] {
        var callbackOnContact: [PhysicsCategory: [PhysicsCategory]] = [:]
        callbackOnContact[.character] = [.obstacle, .ground, .prize]
        
        return callbackOnContact
    }
    
    static var gravityAffectedCategories: [PhysicsCategory] = [.character]
    static var dynamicCategories: [PhysicsCategory] = [.character]
    static var allowedRotationCategories: [PhysicsCategory] = []
    
    let rawValue: UInt32
        
    static let character = PhysicsCategory(rawValue: 1)
	static let ground = PhysicsCategory(rawValue: 8)
    static let obstacle = PhysicsCategory(rawValue: 2)
    static let prize = PhysicsCategory(rawValue: 4)
        
    func shouldCallbackOnContact(with category: PhysicsCategory) -> Bool {
        if let contacts = PhysicsCategory.callbackOnContact[self] { return contacts.contains(category) }
        
        return false
    }
}

extension PhysicsCategory: Hashable {
    var hashValue: Int { return Int(rawValue) }
}
