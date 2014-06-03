//
//  Terrain.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 03/06/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import UIKit
import SpriteKit

class Terrain: NSObject {
    
    func create(parentNode: SKScene!){
        let terrainTexture = SKTexture(imageNamed:"terrain")

        
        
        let node1 = SKSpriteNode(texture: terrainTexture)
        node1.anchorPoint = CGPointMake(0, 1)
        node1.position = CGPointMake(0, 0)

        let node2 = SKSpriteNode(texture: terrainTexture)
        node2.anchorPoint = CGPointMake(0, 1)
        node2.position = CGPointMake(320, 0)
        
        
        
        let size = CGSizeMake(2*640, 60)

        let terrain = SKSpriteNode(texture: terrainTexture, size: size)

        terrain.zPosition = 1
        let location = CGPointMake(0.0, 60)
        terrain.anchorPoint = CGPointMake(0, 1)
        terrain.position = location
        terrain.addChild(node1)
        terrain.addChild(node2)
        parentNode.addChild(terrain)
        
        
        let terrainBody = SKNode()
        terrainBody.position = CGPointMake(160.0, 35)
        terrainBody.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(320, 20))

        terrainBody.physicsBody.dynamic = false
        terrainBody.physicsBody.affectedByGravity = false
        terrainBody.physicsBody.collisionBitMask = 0
//        terrainBody.physicsBody.categoryBitMask = terrainType
//        terrainBody.physicsBody.contactTestBitMask = heroType
        parentNode.addChild(terrainBody)
        
        terrain.runAction(SKAction.repeatActionForever(SKAction.sequence(
            [
                SKAction.moveToX(-320, duration: 5.0),
                SKAction.moveToX(0, duration: 0)
            ]
            )))
        
    }
   
}
