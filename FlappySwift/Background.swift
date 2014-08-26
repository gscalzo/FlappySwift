//
//  Background.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 26/08/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import UIKit
import SpriteKit

class Background {
    private var parallaxNode: SKSpriteNode!
    
    init() {
    }
    
    func addTo(parentNode: SKScene!) -> Background {
        let parentWidth = parentNode.size.width
        let height = parentNode.size.height
        
        createTerrainWidth(parentWidth, height: height, parentNode: parentNode)
        return self
    }
    
    func start() {
        parallaxNode.runAction(SKAction.repeatActionForever(SKAction.sequence(
            [
                SKAction.moveToX(-parallaxNode.size.width/2.0, duration: 20.0),
                SKAction.moveToX(0, duration: 0)
            ]
            )))
    }
    
    private func createTerrainWidth(width: CGFloat, height: CGFloat, parentNode: SKNode) {
        let size = CGSizeMake(2*width, height)
        let size1 = CGSizeMake(width, height)

        let terrainTexture = SKTexture(imageNamed:"background")
        parallaxNode = SKSpriteNode(color: UIColor.whiteColor(), size: size)
//        parallaxNode.zPosition = 1
        
        let location = CGPointMake(0.0, 0)
        parallaxNode.anchorPoint = CGPointMake(0, 0)
        parallaxNode.position = location
        parallaxNode.addChild(node(terrainTexture, position: 0, size: size1))
        parallaxNode.addChild(node(terrainTexture, position: width, size: size1))
        parentNode.addChild(parallaxNode)
    }
    
    private func node(texture: SKTexture, position: CGFloat, size: CGSize) -> SKNode {
        let node = SKSpriteNode(texture: texture, size: size)
        node.anchorPoint = CGPointMake(0, 0)
        node.position = CGPointMake(position, 0)
        
        return node
    }
    
}
