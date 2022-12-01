//
//  ScoreboardEntity.swift
//  Mimi
//
//  Created by Federico Maza on 01/01/2018.
//  Copyright © 2018 Federico Maza. All rights reserved.
//

import GameplayKit

class ScoreboardEntity: GKEntity {
    var score: Int = 0 {
        didSet {
            scoreLabel.text = String(score)
        }
    }
    
	lazy var cookiesCountLabel = SKLabelNode()
    lazy var highscoreLabel = SKLabelNode()
    lazy var scoreLabel = SKLabelNode()
    
    unowned let gameScene: GameScene
    
    init(scene: GameScene) {
        self.gameScene = scene
        
        super.init()
        
        presetComponents(scene: scene)
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented.") }
        
    override func update(deltaTime seconds: TimeInterval) {
		// TODO: Program update behaviour.
    }
        
    func update(score value: Int) {
        score = value
        
        if DataManager.shared.highscore < score {
            DataManager.shared.highscore = score
            
            highscoreLabel.text = String(DataManager.shared.highscore)
        }
    }
        
    private func presetComponents(scene: GameScene) {
        let identityComponent = IdentityComponent(name: .scoreboard)
        addComponent(identityComponent)
        
        let gameSceneWidthVariation = gameScene.frame.width * 0.20
        let gameSceneHeightVariation = gameScene.frame.height * 0.07
                
        let highscorePosition = CGPoint(x: 0 + gameSceneWidthVariation, y: gameScene.frame.height - gameSceneHeightVariation)
        let highscoreLabel = makeLabel(font: FontManager.shared.scoreboardFont, position: highscorePosition)
        let highscoreFontColor = UIColor(red: (254 / 255), green: (219 / 255), blue: (111 / 254), alpha: 1.0)

        highscoreLabel.text = String(DataManager.shared.highscore)
        highscoreLabel.fontColor = highscoreFontColor
        
        let highscoreIcon = makeLabelIcon(for: highscoreLabel, with: ImageName.Scoreboard.goldenCookie)
        let highscoreNode = SKNode()
        
        highscoreNode.addChild(highscoreLabel)
        highscoreNode.addChild(highscoreIcon)
        
        self.highscoreLabel = highscoreLabel
        
        let scorePosition = CGPoint(x: gameScene.frame.width - gameSceneWidthVariation / 2, y: gameScene.frame.height - gameSceneHeightVariation)
        let scoreLabel = makeLabel(font: FontManager.shared.scoreboardFont, position: scorePosition)
        
        scoreLabel.text = String(0)
        
        let scoreFontColor = UIColor(red: (235 / 255), green: (235 / 255), blue: (235 / 254), alpha: 1.0)
        
        scoreLabel.fontColor = scoreFontColor
        
        let scoreIcon = makeLabelIcon(for: scoreLabel, with: ImageName.Scoreboard.bone)
        let scoreNode = SKNode()
        
        scoreNode.addChild(scoreLabel)
        scoreNode.addChild(scoreIcon)
        
        self.scoreLabel = scoreLabel

        let nodeComponent = NodeComponent(childs: [highscoreNode, scoreNode])
        
        addComponent(nodeComponent)
    }
    
    private func makeLabel(font: UIFont, position: CGPoint) -> SKLabelNode {
        let label = SKLabelNode(fontNamed: font.fontName)
        
        label.fontSize = font.pointSize
        label.position = position
        label.zPosition = PositionCategory.interface.asCGFloat
        
        return label
    }
    
    private func makeLabelIcon(for label: SKLabelNode, with imageName: String) -> SKSpriteNode {
        let texture = AtlasManager.shared.textureAtlas.textureNamed(imageName)
        let sprite = SKSpriteNode(texture: texture)

        sprite.position = label.position
        sprite.position.x = sprite.position.x - (label.frame.width / 2 + sprite.frame.width / 2 + sprite.frame.width / 4)
        sprite.position.y = sprite.position.y + label.frame.height / 2
        sprite.zPosition = label.zPosition
        
        return sprite
    }
}
