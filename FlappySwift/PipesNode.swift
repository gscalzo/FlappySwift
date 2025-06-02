//
//  PipesNode.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 23/02/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//

import SpriteKit

class PipesNode {
    class var kind: String { return "PIPES" }
    private let gapSize: CGFloat = 50
    
    private let pipesNode: SKNode
    private let finalOffset: CGFloat
    private let startingOffset: CGFloat
    
    init(topPipeTexture: String, bottomPipeTexture: String, centerY: CGFloat) {
        pipesNode = SKNode()
        pipesNode.name = PipesNode.kind
        
        let pipeTop = createPipe(imageNamed: topPipeTexture)
        let pipeTopPosition = CGPoint(x: 0, y: centerY + pipeTop.size.height/2 + gapSize)
        pipeTop.position = pipeTopPosition
        pipesNode.addChild(pipeTop)
        
        let pipeBottom = createPipe(imageNamed: bottomPipeTexture)
        let pipeBottomPosition = CGPoint(x: 0 , y: centerY - pipeBottom.size.height/2 - gapSize)
        pipeBottom.position = pipeBottomPosition
        pipesNode.addChild(pipeBottom)
        
        let gapNode = createGap(size: CGSize(
            width: pipeBottom.size.width,
            height: gapSize*2))
        gapNode.position = CGPoint(x: 0, y: centerY)
        pipesNode.addChild(gapNode)
        
        finalOffset = -pipeBottom.size.width
        startingOffset = -finalOffset
    }
    
    @discardableResult
    func addTo(_ parentNode: SKSpriteNode) -> PipesNode {
        let pipePosition = CGPoint(x: parentNode.size.width + startingOffset, y: 0)
        pipesNode.position = pipePosition
        pipesNode.zPosition = 4
        
        parentNode.addChild(pipesNode)
        return self
    }
    
    func start() {
        pipesNode.run(SKAction.sequence(
            [
                SKAction.moveTo(x: finalOffset, duration: 6.0),
                SKAction.removeFromParent()
            ]
            ))
    }
}

// Creators
private func createPipe(imageNamed: String) -> SKSpriteNode {
    let pipeNode = SKSpriteNode(imageNamed: imageNamed)
    let size = CGSize(width: pipeNode.size.width, height: pipeNode.size.height)
    pipeNode.physicsBody = SKPhysicsBody.rectSize(size) {
        body in
        body.isDynamic           = false
        body.affectedByGravity = false
        body.categoryBitMask   = BodyType.pipe.rawValue
        body.collisionBitMask  = BodyType.pipe.rawValue
    }
    return pipeNode
}

private func createGap(size: CGSize) -> SKSpriteNode {
    let gapNode = SKSpriteNode(color: .clear, size: size)
    gapNode.zPosition = 6
    gapNode.physicsBody = SKPhysicsBody.rectSize(size) {
        body in
        body.isDynamic = false
        body.affectedByGravity = false
        body.categoryBitMask = BodyType.gap.rawValue
        body.collisionBitMask = BodyType.gap.rawValue
    }
    return gapNode
}
