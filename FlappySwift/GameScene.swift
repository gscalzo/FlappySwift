//
//  GameScene.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 02/06/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

enum BodyType : UInt32 {
    case bird = 1
    case world = 2
    case pipe = 4
    case gap = 8
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    var screenNode: SKSpriteNode!
    var bird: Bird!
    var actors: [Startable]!
    
    override func didMoveToView(view: SKView) {
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -3)
        
        screenNode = SKSpriteNode(color: UIColor.clearColor(), size: self.size)
        addChild(screenNode)
        
        let bg = Background().addTo(screenNode)
        let te = Ground().addTo(screenNode)
        let pi = Pipes().addTo(screenNode)
        bird = Bird().addTo(screenNode).position(CGPointMake(30.0, 400.0))
        actors = [bg, te, pi, bird]

        for actor in actors {
            actor.start()
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        bird.flap()
    }
    
    override func update(currentTime: CFTimeInterval) {
        bird.update()
    }
    
    func didBeginContact(contact: SKPhysicsContact!) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch (contactMask) {
        case BodyType.pipe.toRaw() |  BodyType.bird.toRaw():
            println("pipe")
            bird.fallOff()
        case BodyType.world.toRaw() | BodyType.bird.toRaw():
            for actor in actors {
                actor.stop()
            }
            
            let shakeAction = SKAction.shake(0.1, amplitudeX: 20)
            screenNode.runAction(shakeAction)
            
        default:
            return
        }
        
    }
    
    func didEndContact(contact: SKPhysicsContact!) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch (contactMask) {
        case BodyType.gap.toRaw() |  BodyType.bird.toRaw():
            println("gap")            
        default:
            return
        }
    }
    
    
}


