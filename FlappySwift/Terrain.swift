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
    private var terrain: ParallaxNode!
    
    init() {
    }
    
    func addTo(parentNode: SKScene!) -> Terrain {
        
        let parentWidth = parentNode.size.width
        let height = CGFloat(60.0)
        
        terrain = ParallaxNode(width: parentWidth,
                              height: height,
                        textureNamed: "terrain.png").addTo(parentNode)
        
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
        terrain.start(duration: 5.0)
    }
}
