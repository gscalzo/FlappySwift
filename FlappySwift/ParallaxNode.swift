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
    private let terrain: SKSpriteNode!
    
    init(width: CGFloat, height: CGFloat, parentNode: SKNode) {
        let size = CGSizeMake(2*width, height)
        
        let terrainTexture = SKTexture(imageNamed:"terrain")
        terrain = SKSpriteNode(texture: terrainTexture, size: size)
        //        terrain.zPosition = 1
        
        let location = CGPointMake(0.0, 0)
        terrain.anchorPoint = CGPointMake(0, 0)
        terrain.position = location
        terrain.addChild(node(terrainTexture, position: 0))
        terrain.addChild(node(terrainTexture, position: width))
        parentNode.addChild(terrain)
    }
    
    private func node(texture: SKTexture, position: CGFloat) -> SKNode {
        let node = SKSpriteNode(texture: texture)
        node.anchorPoint = CGPointMake(0, 1)
        node.position = CGPointMake(position, 0)
        
        return node
    }
   
    
    func start(#duration: NSTimeInterval) {
        terrain.runAction(SKAction.repeatActionForever(SKAction.sequence(
            [
                SKAction.moveToX(-terrain.size.width/2.0, duration: duration),
                SKAction.moveToX(0, duration: 0)
            ]
            )))
    }
}