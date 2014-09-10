//
//  Ground.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 03/06/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

class Ground  {
    private var parallaxNode: ParallaxNode!
    private let textureName: String
    
    init(textureNamed textureName: String) {
        self.textureName = textureName
    }
    
    func addTo(parentNode: SKSpriteNode!) -> Ground {
        let width = parentNode.size.width
        let height = CGFloat(60.0)
        
        parallaxNode = ParallaxNode(width: width,
                              height: height,
                        textureNamed: textureName).zPosition(5).addTo(parentNode)
        let groundBody = SKNode()
        groundBody.position = CGPoint(x: width/2.0, y: height/2)
        
        //        groundBody.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: width, height: height))
        //        groundBody.physicsBody!.dynamic = false
        //        groundBody.physicsBody!.affectedByGravity = false
        //        groundBody.physicsBody!.categoryBitMask = BodyType.world.toRaw()
        //        groundBody.physicsBody!.collisionBitMask = BodyType.world.toRaw()
        
        groundBody.physicsBody = SKPhysicsBody.rectSize(CGSize(width: width, height: height)){ body in
            body.dynamic = false
            body.affectedByGravity = false
            body.categoryBitMask = BodyType.world.toRaw()
            body.collisionBitMask = BodyType.world.toRaw()
        }
        
        parentNode.addChild(groundBody)
        return self
    }
}

// Startable
extension Ground : Startable {
    func start() -> Startable {
        parallaxNode.start(duration: 5.0)
        return self
    }
    
    func stop() -> Startable {
        parallaxNode.stop()
        return self
    }
}
