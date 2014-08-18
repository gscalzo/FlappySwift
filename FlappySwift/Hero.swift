//
//  Hero.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 03/06/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

class Hero {
    let node: SKSpriteNode
    
    init(imageNamed name: String!){
        
        node = SKSpriteNode(imageNamed: name)
        
        node.physicsBody = SKPhysicsBody(rectangleOfSize:
            CGSizeMake(node.size.width, node.size.height))
            
        node.physicsBody.dynamic = true
        self.animate()
    
    }

    func position(position: CGPoint) {
        node.position = position
    }
    
    func addTo(scene: SKNode) {
        scene.addChild(node)
    }
    
    func animate(){
        let animationFrames = [
        SKTexture(imageNamed:"hero1"),
        SKTexture(imageNamed:"hero2")
        ]
        

        node.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(animationFrames, timePerFrame: 0.1)))
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


}
