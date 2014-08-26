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
        let width = parentNode.size.width
        let height = parentNode.size.height
        
        createTerrainWidth("background",
            size: CGSize(width: width, height: height),
                           parentNode: parentNode)
        return self
    }
    
    func start() {
        let duration = 20.0
        parallaxNode.runAction(SKAction.repeatActionForever(SKAction.sequence(
            [
                SKAction.moveToX(-parallaxNode.size.width/2.0, duration: duration),
                SKAction.moveToX(0, duration: 0)
            ]
            )))
    }
    
    private func createTerrainWidth(imageNamed: String, size: CGSize, parentNode: SKNode) {
        parallaxNode = SKSpriteNode(color: UIColor.whiteColor(),
                                      size: CGSize( width: 2*size.width,
                                                   height: size.height))
        
        parallaxNode.addChild(nodeImage(imageNamed, position: 0, size: size))
        parallaxNode.addChild(nodeImage(imageNamed, position: size.width, size: size))
        parentNode.addChild(parallaxNode)
    }
    
    private func nodeImage(imageNamed: String, position: CGFloat, size: CGSize) -> SKNode {
        let texture = SKTexture(imageNamed: imageNamed)
        let node = SKSpriteNode(texture: texture, size: size)
        node.anchorPoint = CGPointMake(0, 0)
        node.position = CGPointMake(position, 0)
        
        return node
    }
    
}
