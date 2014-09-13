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
    private var bird: Bird!
    private var dbgLbl: SKLabelNode!

    override func didMoveToView(view: SKView) {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -3)

        screenNode = SKSpriteNode(color: UIColor.clearColor(), size: self.size)
        addChild(screenNode)        
        
        Background(textureNamed: "background").addTo(screenNode).start()
        Ground(textureNamed: "ground").addTo(screenNode).start()
        bird = Bird(textureNames: ["bird1", "bird2"]).addTo(screenNode)
        bird.position = CGPointMake(30.0, 400.0)
        bird.start()

        Pipes(textureNames: ["pipeTop.png", "pipeBottom.png"]).addTo(screenNode).start()
        dbgLbl = addDbgLbTo(screenNode)
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
            log("Contact with a pipe")
        case BodyType.ground.toRaw() | BodyType.bird.toRaw():
            log("Contact with ground")
        default:
            return
        }
        
    }
    
    func didEndContact(contact: SKPhysicsContact!) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch (contactMask) {
        case BodyType.gap.toRaw() |  BodyType.bird.toRaw():
            log("Exit from gap")
        default:
            return
        }
    }
}

extension GameScene {
    private func addDbgLbTo(parentNode: SKSpriteNode) -> SKLabelNode {
        let lbl = SKLabelNode(text: "--")
        lbl.zPosition = 6
        lbl.fontName = "MarkerFelt-Wide"
        lbl.fontSize = 30
        lbl.fontColor = UIColor.blackColor()
        lbl.position = CGPoint(x: parentNode.size.width/2, y:  30)
        parentNode.addChild(lbl)
        return lbl
    }
    
    private func log(msg: String) {
        dbgLbl.text = msg
        println(msg)
    }

}
