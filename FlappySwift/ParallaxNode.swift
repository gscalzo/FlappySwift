//
//  ParallaxNode.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 26/08/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import UIKit
import SpriteKit

class ParallaxNode {
    private let node: SKSpriteNode!
    
    init(textureNamed: String) {
        
        let firstNode = createNode(textureNamed, x: 0)
        let size = CGSizeMake(2*firstNode.size.width, firstNode.size.height)
        
        node = SKSpriteNode(color: UIColor.whiteColor(), size: size)

        node.anchorPoint = CGPointZero
        node.position = CGPointZero
        node.addChild(firstNode)
        node.addChild(createNode(textureNamed, x: firstNode.size.width))
    }
    
    private func createNode(textureNamed: String, x: CGFloat) -> SKSpriteNode {
        let node = SKSpriteNode(imageNamed: textureNamed, normalMapped: true)
//                node.lightingBitMask = BodyType.bird.rawValue
        node.anchorPoint = CGPointZero
        node.position = CGPoint(x: x, y: 0)
        
        
        return node
    }
    
    func zPosition(zPosition: CGFloat) -> ParallaxNode {
        node.zPosition = zPosition
        return self
    }
   
    func addTo(parentNode: SKSpriteNode) -> ParallaxNode {
        parentNode.addChild(node)
        return self
    }
    
    func start(#duration: NSTimeInterval) {
        node.runAction(SKAction.repeatActionForever(SKAction.sequence(
            [
                SKAction.moveToX(-node.size.width/2.0, duration: duration),
                SKAction.moveToX(0, duration: 0)
            ]
            )))
    }
    
    func stop() {
        node.removeAllActions()
    }
    
}