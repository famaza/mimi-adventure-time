//
//  DisplayPrecedence.swift
//  Mimi
//
//  Created by Federico Maza on 10/3/17.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import CoreGraphics

struct PositionCategory: OptionSet {
    var asCGFloat: CGFloat { return CGFloat(rawValue) }
    
    let rawValue: Int
    
	static let alert = PositionCategory(rawValue: 128)
    static let background = PositionCategory(rawValue: 1)
	static let character = PositionCategory(rawValue: 4)
    static let foreground = PositionCategory(rawValue: 2)
	static let ground = PositionCategory(rawValue: 32)
	static let interface = PositionCategory(rawValue: 64)
    static let obstacle = PositionCategory(rawValue: 8)
    static let prize = PositionCategory(rawValue: 16)
}
