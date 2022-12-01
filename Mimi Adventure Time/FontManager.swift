//
//  FontManager.swift
//  Mimi
//
//  Created by Federico Maza on 13/01/2018.
//  Copyright © 2018 Federico Maza. All rights reserved.
//

import UIKit

class FontManager {
    let scoreboardFont: UIFont
	let informationFont: UIFont
        
    static let shared = FontManager()
        
    private init() {
        let fontSize: CGFloat = 40
        
        guard let scoreboardFont = UIFont(name: FontName.zeroFourBNineteen, size: fontSize), let informationFont = UIFont(name: FontName.blocked, size: fontSize) else {
            self.scoreboardFont = UIFont()
            self.informationFont = UIFont()

            return
        }
        
        self.scoreboardFont = scoreboardFont
        self.informationFont = informationFont
    }
}
