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
                
        let gapNode = createGap(size: CGSize(
                                        width: pipeBottom.size.width,
                                        height: 600))
        gapNode.position = CGPoint(x: 0, y: centerY)
        pipesNode.addChild(gapNode)
        
        finalOffset = -pipeBottom.size.width/2
        startingOffset = -finalOffset
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

// Creators
extension PipePair {
    private func createPipe(#imageNamed: String) -> SKSpriteNode {
        let pipeNode = SKSpriteNode(imageNamed: imageNamed)
        pipeNode.shadowCastBitMask = BodyType.bird.rawValue
        pipeNode.physicsBody = SKPhysicsBody.rectSize(pipeNode.size) {
            body in
            body.dynamic           = false
            body.affectedByGravity = false
            body.categoryBitMask   = BodyType.pipe.rawValue
            body.collisionBitMask  = BodyType.pipe.rawValue
        }
        return pipeNode
    }
    
    private func createGap(#size: CGSize) -> SKSpriteNode {
        let gapNode = SKSpriteNode(color: UIColor.clearColor(),
            size: size)
        gapNode.physicsBody = SKPhysicsBody.rectSize(size) {
            body in
            body.dynamic = false
            body.affectedByGravity = false
            body.categoryBitMask = BodyType.gap.rawValue
            body.collisionBitMask = BodyType.gap.rawValue
        }
        return gapNode
    }
}