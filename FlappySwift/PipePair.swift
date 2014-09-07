//
//  PipePair.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 29/08/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

class PipePair {
    
//    class let kind : String = "PIPES" // class variables not yet supported
    class var kind : String { get {return "PIPES"} }
    
    private let gapSize: CGFloat = 50
    private var pipesNode: SKNode!
    private var finalOffset: CGFloat!
    private var startingOffset: CGFloat!
    
    init(textures: [String], centerY: CGFloat){
        pipesNode = SKNode()
        pipesNode.name = PipePair.kind

        let pipeTop = createPipe(imageNamed: textures[0])
        let pipeTopPosition = CGPoint(x: 0, y: centerY + pipeTop.size.height/2 + gapSize)
        pipeTop.position = pipeTopPosition
        pipesNode.addChild(pipeTop)

        let pipeBottom = createPipe(imageNamed: textures[1])
        let pipeBottomPosition = CGPoint(x: 0 , y: centerY - pipeBottom.size.height/2 - gapSize)
        pipeBottom.position = pipeBottomPosition
        pipesNode.addChild(pipeBottom)
        
        
        let gapNode = SKSpriteNode(color: UIColor.clearColor(),
            size: CGSize(width: pipeBottom.size.width
            , height: gapSize*2))
        gapNode.position = CGPoint(x: 0, y: centerY)
        pipesNode.addChild(gapNode)
        gapNode.physicsBody = SKPhysicsBody(rectangleOfSize: gapNode.size)
        gapNode.physicsBody!.dynamic = false
        gapNode.physicsBody!.affectedByGravity = false
        gapNode.physicsBody!.categoryBitMask = BodyType.gap.toRaw()
        gapNode.physicsBody!.collisionBitMask = BodyType.gap.toRaw()
        
        finalOffset = -pipeBottom.size.width/2
        startingOffset = -finalOffset
    }
    
    private func createPipe(#imageNamed: String) -> SKSpriteNode {
        let pipeNode = SKSpriteNode(imageNamed: imageNamed)
        pipeNode.shadowCastBitMask = BodyType.bird.toRaw()
        pipeNode.physicsBody = SKPhysicsBody(rectangleOfSize: pipeNode.size)
        pipeNode.physicsBody!.dynamic = false
        pipeNode.physicsBody!.affectedByGravity = false
        pipeNode.physicsBody!.categoryBitMask = BodyType.pipe.toRaw()
        pipeNode.physicsBody!.collisionBitMask = BodyType.pipe.toRaw()
        return pipeNode
    }
    
    func addTo(parentNode: SKSpriteNode) -> PipePair {
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