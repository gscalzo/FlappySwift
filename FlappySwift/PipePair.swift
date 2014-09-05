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
    private var finalOffset: CGFloat!
    private var startingOffset: CGFloat!
    
    init(centerY: CGFloat){
        pipesNode = SKNode()
        
        let pipeTop = SKSpriteNode(imageNamed: "pipeTop.png")
        let pipeTopPosition = CGPoint(x: 0, y: centerY + pipeTop.size.height/2 + gapSize)
        
        pipeTop.position = pipeTopPosition
        pipesNode.addChild(pipeTop)
        pipeTop.physicsBody = SKPhysicsBody(rectangleOfSize: pipeTop.size)
        pipeTop.physicsBody.pinned = true
        pipeTop.physicsBody.dynamic = false
        pipeTop.physicsBody.affectedByGravity = false
        pipeTop.physicsBody.collisionBitMask = BodyType.bird.toRaw()
        pipeTop.physicsBody.categoryBitMask = BodyType.pipe.toRaw()
        pipeTop.physicsBody.contactTestBitMask = BodyType.bird.toRaw()

        
        let pipeBottom = SKSpriteNode(imageNamed: "pipeBottom.png")
        let pipeBottomPosition = CGPoint(x: 0 , y: centerY - pipeBottom.size.height/2 - gapSize)
        pipeBottom.position = pipeBottomPosition
        pipeBottom.physicsBody = SKPhysicsBody(rectangleOfSize: pipeBottom.size)
        pipeBottom.physicsBody.dynamic = false
        pipeBottom.physicsBody.affectedByGravity = false
        pipeBottom.physicsBody.collisionBitMask = BodyType.bird.toRaw()
        pipeBottom.physicsBody.categoryBitMask = BodyType.pipe.toRaw()
        pipeBottom.physicsBody.contactTestBitMask = BodyType.bird.toRaw()

        pipesNode.addChild(pipeBottom)
        finalOffset = -pipeBottom.size.width/2
        startingOffset = -finalOffset
    }
    
    func addTo(parentNode: SKScene!) -> PipePair {
        let pipePosition = CGPoint(x: parentNode.size.width + startingOffset, y: 0)
        pipesNode.position = pipePosition
        
        parentNode.addChild(pipesNode)
        return self
    }
    
    func start() {
        pipesNode.runAction(SKAction.sequence(
            [
                SKAction.moveToX(finalOffset, duration: 6.0),
                SKAction.removeFromParent()
            ]
            ))
    }
}