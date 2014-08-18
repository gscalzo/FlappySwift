//
//  Bird.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 03/06/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

class Bird {
    private let node: SKSpriteNode
    
    init(){
        node = SKSpriteNode(imageNamed: "bird1")
        node.physicsBody = SKPhysicsBody(
            rectangleOfSize: node.size)
        
        node.physicsBody.dynamic = true
        animate()
    }
    
    func position(position: CGPoint) {
        node.position = position
    }
    
    func addTo(scene: SKNode) {
        scene.addChild(node)
    }
    
    
    func update() {
        switch node.physicsBody.velocity.dy {
        case let dy where dy > 30.0:
            node.zRotation = (3.14/6.0)
        case let dy where dy < -100.0:
            node.zRotation = -1*(3.14/4.0)
        default:
            node.zRotation = 0.0
        }
    }
    
    func flap () {
        node.physicsBody.velocity = CGVectorMake(0, 0)
        node.physicsBody.applyImpulse(CGVectorMake(0, 7))
    }

    private func animate(){
        let animationFrames = [
            SKTexture(imageNamed:"bird1"),
            SKTexture(imageNamed:"bird2")
        ]
        
        node.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(animationFrames, timePerFrame: 0.1)))
    }
    
}
