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
    private let textures: [String]
    
    init(textures: [String]) {
        self.textures = textures
        
        node = SKSpriteNode(imageNamed: textures[0])
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
        
        addLightEmitter()
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
        let animationFrames = textures.map { texName in
            SKTexture(imageNamed: texName)
        }
        
        node.runAction(
            SKAction.repeatActionForever(
            SKAction.animateWithTextures(animationFrames, timePerFrame: 0.1)
            ))
    }
    
    private func addLightEmitter() {
        let light = SKLightNode()
        light.categoryBitMask = BodyType.bird.toRaw()
        light.falloff = 1
        light.ambientColor = UIColor.whiteColor()
        light.lightColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 0.5)
        light.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
        node.addChild(light)
    }
}
