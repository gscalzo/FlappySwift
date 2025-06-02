//
//  PipesNode.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 23/02/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//

import SpriteKit
import Foundation

// Add BodyType enum here to resolve scope issues
enum BodyType: UInt32 {
    case bird   = 1  // (1 << 0)
    case ground = 2  // (1 << 1)
    case pipe   = 4  // (1 << 2)
    case gap    = 8  // (1 << 3)
}

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
    let bodyWidth = pipeNode.size.width * 0.7
    let bodyHeight = pipeNode.size.height * 0.99
    let size = CGSize(width: bodyWidth, height: bodyHeight)
    pipeNode.physicsBody = SKPhysicsBody(rectangleOf: size)
    pipeNode.physicsBody?.isDynamic = false
    pipeNode.physicsBody?.affectedByGravity = false
    pipeNode.physicsBody?.categoryBitMask = BodyType.pipe.rawValue
    pipeNode.physicsBody?.collisionBitMask = BodyType.pipe.rawValue
    return pipeNode
}

private func createGap(size: CGSize) -> SKSpriteNode {
    let gapNode = SKSpriteNode(color: .clear, size: size)
    gapNode.zPosition = 6
    gapNode.physicsBody = SKPhysicsBody(rectangleOf: size)
    gapNode.physicsBody?.isDynamic = false
    gapNode.physicsBody?.affectedByGravity = false
    gapNode.physicsBody?.categoryBitMask = BodyType.gap.rawValue
    gapNode.physicsBody?.collisionBitMask = BodyType.gap.rawValue
    return gapNode
}
