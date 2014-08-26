//
//  GameScene.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 02/06/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var bird: Bird!
    
    override func didMoveToView(view: SKView) {
//        let backgroundTexture = SKTexture(imageNamed:"background")
//
//        let background = SKSpriteNode(texture: backgroundTexture, size: self.frame.size)
//        println(self.frame.size)
//        background.position =  CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
//        
////        addChild(background)
        
        scaleMode = SKSceneScaleMode.AspectFill
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVectorMake(0, -3)
        
        
        Background().addTo(self).start()
        Terrain().addTo(self).start()

        bird = Bird()
        bird.position(CGPointMake(30.0, 400.0))
        bird.addTo(self)
        

    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        bird.flap()
    }
   
    override func update(currentTime: CFTimeInterval) {
        bird.update()
    }
    
    
    func didBeginContact(contact: SKPhysicsContact!) {
    }
    
    func didEndContact(contact: SKPhysicsContact!)
    {
    }
    

}


