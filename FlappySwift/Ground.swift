//
//  Ground.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 03/06/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

class Ground : Startable {
    private var parallaxNode: ParallaxNode!
    private let texture: String
    
    init(texture: String) {
        self.texture = texture
    }
    
    func addTo(parentNode: SKSpriteNode!) -> Ground {
        
        let width = parentNode.size.width
        let height = CGFloat(60.0)
        
        parallaxNode = ParallaxNode(width: width,
                              height: height,
                        textureNamed: texture).zPosition(5).addTo(parentNode)
        
        let groundBody = SKNode()
        groundBody.position = CGPoint(x: width/2.0, y: height/2)
        
        groundBody.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: width, height: height))
        groundBody.physicsBody!.dynamic = false
        groundBody.physicsBody!.affectedByGravity = false
        groundBody.physicsBody!.categoryBitMask = BodyType.world.toRaw()
        groundBody.physicsBody!.collisionBitMask = BodyType.world.toRaw()
        parentNode.addChild(groundBody)
        return self
    }

    func start() -> Startable {
        parallaxNode.start(duration: 5.0)
        return self
    }
    
    func stop() -> Startable {
        parallaxNode.stop()
        return self
    }
    
}
