//
//  Terrain.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 03/06/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import UIKit
import SpriteKit

class Terrain {
    private var terrain: SKSpriteNode!
    
    init() {
    }
    
    func addTo(parentNode: SKScene!) -> Terrain {
        
        let parentWidth = parentNode.size.width
        let height = CGFloat(60.0)
        
        createTerrainWidth(parentWidth, height: height, parentNode: parentNode)
        
        let terrainBody = SKNode()
        terrainBody.position = CGPointMake(parentWidth/2.0, height/2)
        terrainBody.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(parentWidth, height))
        
        terrainBody.physicsBody.dynamic = false
        terrainBody.physicsBody.affectedByGravity = false
        terrainBody.physicsBody.collisionBitMask = 0
        //        terrainBody.physicsBody.categoryBitMask = terrainType
        //        terrainBody.physicsBody.contactTestBitMask = heroType
        parentNode.addChild(terrainBody)
        return self
    }
    
    func start() {
        terrain.runAction(SKAction.repeatActionForever(SKAction.sequence(
            [
                SKAction.moveToX(-terrain.size.width/2.0, duration: 5.0),
                SKAction.moveToX(0, duration: 0)
            ]
            )))
    }
    
    private func createTerrainWidth(width: CGFloat, height: CGFloat, parentNode: SKNode) {
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
    
}
