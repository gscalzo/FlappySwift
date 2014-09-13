//
//  GameScene.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 02/06/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

enum BodyType : UInt32 {
    case bird   = 1 // (1 << 0)
    case ground = 2 // (1 << 1)
    case pipe   = 4 // (1 << 2)
    case gap    = 8 // (1 << 3)
}

class GameScene: SKScene {
    private var screenNode: SKSpriteNode!
    private var actors: [Startable]!
    private var bird: Bird!
    private var score: Score!

    override func didMoveToView(view: SKView) {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -3)

        screenNode = SKSpriteNode(color: UIColor.clearColor(), size: self.size)
        addChild(screenNode)        
        
        let bg = Background(textureNamed: "background").addTo(screenNode)
        let gr = Ground(textureNamed: "ground").addTo(screenNode)
        bird = Bird(textureNames: ["bird1", "bird2"]).addTo(screenNode)
        bird.position = CGPointMake(30.0, 400.0)

        let pi = Pipes(textureNames: ["pipeTop.png", "pipeBottom.png"]).addTo(screenNode)
        actors = [bg, gr, pi, bird]

        score = Score().addTo(screenNode)

        for actor in actors {
            actor.start()
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        bird.update()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        bird.flap()
    }
}

// Contacts
extension GameScene: SKPhysicsContactDelegate {
    func didBeginContact(contact: SKPhysicsContact!) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch (contactMask) {
        case BodyType.pipe.toRaw() |  BodyType.bird.toRaw():
            bird.pushDown()
        case BodyType.ground.toRaw() | BodyType.bird.toRaw():
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
            score.increase()
        default:
            return
        }
    }
}

