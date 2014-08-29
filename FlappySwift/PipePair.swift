//
//  PipePair.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 29/08/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

class PipePair {
    private var pipesNode: SKNode!
    private var finalPositionX: CGFloat!
    
    init(centerY: CGFloat){
        pipesNode = SKNode()
        
        let pipeTopPosition = CGPoint(x: 0, y: centerY + 40)
        let pipeBottomPosition = CGPoint(x: 0, y: centerY - 40)
        
        let pipe1 = SKSpriteNode(imageNamed: "pipeTop.png")
        pipe1.anchorPoint = CGPoint(x: 0, y: 0)
        pipe1.position = pipeTopPosition
        pipesNode.addChild(pipe1)
        
        let pipe2 = SKSpriteNode(imageNamed: "pipeBottom.png")
        pipe2.anchorPoint = CGPoint(x: 0, y: 1)
        pipe2.position = pipeBottomPosition
        pipesNode.addChild(pipe2)
        finalPositionX = pipe2.size.width
    }
    
    func addTo(parentNode: SKScene!) -> PipePair {
        let pipePosition = CGPoint(x: parentNode.size.width, y: 0)
        pipesNode.position = pipePosition
        
        parentNode.addChild(pipesNode)
        return self
    }
    
    func start() {
        pipesNode.runAction(SKAction.repeatActionForever(SKAction.sequence(
            [
                SKAction.moveToX(-finalPositionX, duration: 6.0),
                SKAction.removeFromParent()
            ]
            )))
    }
}