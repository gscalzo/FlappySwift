//
//  PipePair.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 29/08/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

class PipePair {
    private let gapSize: CGFloat = 50
    private var pipesNode: SKNode!
    private var finalPositionX: CGFloat!
    
    init(centerY: CGFloat){
        pipesNode = SKNode()
        
        let pipeTopPosition = CGPoint(x: 0, y: centerY + gapSize)
        let pipeBottomPosition = CGPoint(x: 0, y: centerY - gapSize)
        
        let pipeTop = SKSpriteNode(imageNamed: "pipeTop.png")
        pipeTop.anchorPoint = CGPoint(x: 0, y: 0)
        pipeTop.position = pipeTopPosition
        pipesNode.addChild(pipeTop)
        
        let pipeBottom = SKSpriteNode(imageNamed: "pipeBottom.png")
        pipeBottom.anchorPoint = CGPoint(x: 0, y: 1)
        pipeBottom.position = pipeBottomPosition
        pipesNode.addChild(pipeBottom)
        finalPositionX = pipeBottom.size.width
    }
    
    func addTo(parentNode: SKScene!) -> PipePair {
        let pipePosition = CGPoint(x: parentNode.size.width, y: 0)
        pipesNode.position = pipePosition
        
        parentNode.addChild(pipesNode)
        return self
    }
    
    func start() {
        pipesNode.runAction(SKAction.sequence(
            [
                SKAction.moveToX(-finalPositionX, duration: 6.0),
                SKAction.removeFromParent()
            ]
            ))
    }
}