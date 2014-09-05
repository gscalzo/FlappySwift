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
        
        let pipeTop = createPipe(imageNamed: "pipeTop.png")
        let pipeTopPosition = CGPoint(x: 0, y: centerY + pipeTop.size.height/2 + gapSize)
        pipeTop.position = pipeTopPosition
        pipesNode.addChild(pipeTop)

        // creare funzione builder        
        let pipeBottom = createPipe(imageNamed: "pipeBottom.png")
        let pipeBottomPosition = CGPoint(x: 0 , y: centerY - pipeBottom.size.height/2 - gapSize)
        pipeBottom.position = pipeBottomPosition
        pipesNode.addChild(pipeBottom)
        
        finalOffset = -pipeBottom.size.width/2
        startingOffset = -finalOffset
    }
    
    private func createPipe(#imageNamed: String) -> SKSpriteNode {
        let pipeNode = SKSpriteNode(imageNamed: imageNamed)
        pipeNode.physicsBody = SKPhysicsBody(rectangleOfSize: pipeNode.size)
        pipeNode.physicsBody!.pinned = true
        pipeNode.physicsBody!.dynamic = false
        pipeNode.physicsBody!.affectedByGravity = false
        pipeNode.physicsBody!.collisionBitMask = BodyType.bird.toRaw()
        pipeNode.physicsBody!.categoryBitMask = BodyType.pipe.toRaw()
        pipeNode.physicsBody!.contactTestBitMask = BodyType.bird.toRaw()
        return pipeNode
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