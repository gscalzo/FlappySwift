//
//  GameScene.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 02/06/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

enum BodyType : UInt32 {
    case bird   = 1  // (1 << 0)
    case ground = 2  // (1 << 1)
    case pipe   = 4  // (1 << 2)
    case gap    = 8  // (1 << 3)
    case bomb   = 16 // (1 << 4)
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
        
        let textures = Textures.book()
        let sk = Background(textureNamed: textures.sky, duration:60.0).addTo(screenNode)
        let bg = Background(textureNamed: textures.background, duration:20.0).addTo(screenNode)
        let te = Ground(textureNamed: textures.ground).addTo(screenNode)
        bird = Bird(textureNames: textures.bird).addTo(screenNode)
        bird.position = CGPointMake(30.0, 400.0)
        let pi = Pipes(textureNames: textures.pipes).addTo(screenNode)
        actors = [sk, bg, te, pi, bird]

        score = Score().addTo(screenNode)

        for actor in actors {
            actor.start()
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        bird.update()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        switch touches.count {
            case 1: bird.flap()
            default: shoot()
        }
    }
}

// Contacts
extension GameScene: SKPhysicsContactDelegate {
    func didBeginContact(contact: SKPhysicsContact!) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch (contactMask) {
        case BodyType.pipe.rawValue |  BodyType.bomb.rawValue:
            println("Contact with a bomb")
            if contact.bodyA.categoryBitMask == BodyType.pipe.rawValue {
                explode(pipe: contact.bodyA.node as SKSpriteNode)
            } else {
                explode(pipe: contact.bodyB.node as SKSpriteNode)
            }
        case BodyType.pipe.rawValue |  BodyType.bird.rawValue:
            println("Contact with a pipe")
            bird.pushDown()
        case BodyType.ground.rawValue | BodyType.bird.rawValue:
            println("Contact with ground")
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
        case BodyType.gap.rawValue |  BodyType.bird.rawValue:
            println("Contact with gap")
            score.increase()
        default:
            return
        }
    }
}

// Explosion
extension GameScene {
    private func shoot(#emitterName: String, finalYPosition: CGFloat) {
        let fireBoltEmmitter = SKEmitterNode.emitterNodeWithName(emitterName)
        fireBoltEmmitter.position = bird.position
        fireBoltEmmitter.physicsBody = SKPhysicsBody.rectSize(CGSize(width: 20, height: 20)) {
            body in
            body.dynamic = true
            body.categoryBitMask    = BodyType.bomb.rawValue
            body.collisionBitMask   = BodyType.bomb.rawValue
            body.contactTestBitMask = BodyType.pipe.rawValue
        }
        screenNode.addChild(fireBoltEmmitter)
        
        fireBoltEmmitter.runAction(SKAction.sequence(
            [
                SKAction.moveByX(500, y: 100, duration: 1),
                SKAction.removeFromParent()
            ]))
    }
    
    private func shoot() {
        shoot(emitterName: "fireBolt", finalYPosition: 1000)
    }
    
    private func explode(#pipe: SKSpriteNode) {
        let explosionEmmitter = SKEmitterNode.emitterNodeWithName("explosion")
        let x = pipe.parent!.position.x
        let y = pipe.position.y
        explosionEmmitter.position = CGPoint(x: x, y: y)
        screenNode.addChild(explosionEmmitter)
        
        pipe.runAction(SKAction.sequence(
            [
                SKAction.fadeAlphaTo(0, duration: 0.1),
                SKAction.removeFromParent()
            ]))
    }
}


