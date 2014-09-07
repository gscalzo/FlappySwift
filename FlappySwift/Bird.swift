//
//  Bird.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 03/06/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

class Bird : Startable {
    private let node: SKSpriteNode
    private var dying = false
    
    init() {
        node = SKSpriteNode(imageNamed: "bird1")
        node.setScale(1.8)
        node.zPosition = 2.0
        
        node.physicsBody = SKPhysicsBody(
            rectangleOfSize: node.size)
        
        node.physicsBody!.dynamic = true
        node.physicsBody!.categoryBitMask = BodyType.bird.toRaw()
        node.physicsBody!.collisionBitMask = BodyType.bird.toRaw()
        node.physicsBody!.contactTestBitMask = BodyType.world.toRaw() |
                                                BodyType.pipe.toRaw() |
                                                BodyType.gap.toRaw()
    }
    
    func position(position: CGPoint) -> Bird{
        node.position = position
        return self
    }
    
    func addTo(scene: SKSpriteNode) -> Bird{
        scene.addChild(node)
        return self
    }
    
    func update() {
        switch node.physicsBody!.velocity.dy {
        case let dy where dy > 30.0:
            node.zRotation = (3.14/6.0)
        case let dy where dy < -100.0:
            node.zRotation = -1*(3.14/4.0)
        default:
            node.zRotation = 0.0
        }
    }
    
    func flap() {
        if !dying {
            node.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
            node.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 6))
        }
    }
    
    func pushDown() {
        dying = true
        node.physicsBody!.applyImpulse(CGVector(dx: 0, dy: -10))
    }
    
    func start() -> Startable {
        animate()
        return self
    }
    
    func stop() -> Startable {
        node.physicsBody!.dynamic = false
        node.removeAllActions()
        return self
    }
    
    private func animate(){
        let animationFrames = ["bird1", "bird2"].map { texName in
            SKTexture(imageNamed: texName)
        }
        
        node.runAction(
            SKAction.repeatActionForever(
            SKAction.animateWithTextures(animationFrames, timePerFrame: 0.1)
            ))
    }
    
}
