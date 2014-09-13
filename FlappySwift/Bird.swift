//
//  Bird.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 03/06/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

class Bird {
    private let node: SKSpriteNode!
    private let textureNames: [String]
    
    var position : CGPoint {
        set { node.position = newValue }
        get { return node.position }
    }
    
    init(textureNames: [String]) {
        self.textureNames = textureNames
        node = createNode()
    }
    
    func addTo(scene: SKSpriteNode) -> Bird{
        scene.addChild(node)
        return self
    }
}

// Creators
extension Bird {
    private func createNode() -> SKSpriteNode {
        let birdNode = SKSpriteNode(imageNamed: textureNames.first!)
        birdNode.setScale(1.8)
        birdNode.zPosition = 2.0
        
        birdNode.physicsBody = SKPhysicsBody(rectangleOfSize: birdNode.size)
        birdNode.physicsBody!.dynamic = true

        return birdNode
    }
}

// Startable
extension Bird : Startable {
    func start() -> Startable {
        animate()
        return self
    }
    
    func stop() -> Startable {
        node.physicsBody!.dynamic = false
        node.removeAllActions()
        return self
    }
}

// Actions
extension Bird {
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
        node.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
        node.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 6))
    }
}

// Private
extension Bird {
    private func animate(){
        let animationFrames = textureNames.map { texName in
            SKTexture(imageNamed: texName)
        }
        
        node.runAction(
            SKAction.repeatActionForever(
                SKAction.animateWithTextures(animationFrames, timePerFrame: 0.1)
            ))
    }
}


