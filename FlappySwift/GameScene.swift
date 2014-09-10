//
//  GameScene.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 02/06/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    private var screenNode: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        
        screenNode = SKSpriteNode(color: UIColor.clearColor(), size: self.size)
        addChild(screenNode)
        
        let backgroundNode = SKSpriteNode(imageNamed: "background")
        backgroundNode.anchorPoint = CGPointZero
        backgroundNode.position = CGPointZero
        screenNode.addChild(backgroundNode)
        
        let groundNode = SKSpriteNode(imageNamed: "ground")
        groundNode.anchorPoint = CGPointZero
        groundNode.position = CGPointZero
        screenNode.addChild(groundNode)
        
    }
    
    override func update(currentTime: CFTimeInterval) {
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    }
}

