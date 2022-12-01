//
//  AvailablePrizes.swift
//  Mimi
//
//  Created by Federico Maza on 28/12/2017.
//  Copyright © 2017 Federico Maza. All rights reserved.
//

import Foundation

struct PrizeCollection {
    static var availablePrizes: [PrizeType] {
        var availables: [PrizeType] = []

        availables.append(.bone)
        availables.append(.steak)
        availables.append(.sneaker)
        availables.append(.tennisBall)
        
        return availables
    }
    
    static var scoreValues: [PrizeType: Int] {
        var scoreValues: [PrizeType: Int] = [:]
        
        scoreValues.updateValue(1, forKey: .bone)
        scoreValues.updateValue(1, forKey: .steak)
        scoreValues.updateValue(1, forKey: .sneaker)
        scoreValues.updateValue(1, forKey: .tennisBall)
        
        return scoreValues
    }
}
