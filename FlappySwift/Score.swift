//
//  Score.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 07/09/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

class Score {
    private var score: SKLabelNode!
    private var currentScore = 0
    
    init(){
        
    }
    
    func addTo(parentNode: SKSpriteNode) -> Score {
        score = SKLabelNode(text: "\(currentScore)")
        score.fontName = "MarkerFelt-Wide"
        score.fontSize = 30
        score.position = CGPoint(x: parentNode.size.width/2, y: parentNode.size.height - 40)
        parentNode.addChild(score)
        return self
    }
    
    func increase() {
        currentScore += 1
        score.text = "\(currentScore)"
    }
}