//
//  GameScene.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 02/06/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var hero: Hero!
    
    override func didMoveToView(view: SKView) {
        let backgroundTexture = SKTexture(imageNamed:"background")

        let background = SKSpriteNode(texture: backgroundTexture, size: self.frame.size)
        background.position =  CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        
        addChild(background)
        
        scaleMode = SKSceneScaleMode.AspectFill
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVectorMake(0, -3)
        
        hero = Hero(imageNamed: "hero1")
        
        hero.position(CGPointMake(350.0, 450.0))
        hero.addTo(self)
        
        Terrain().create(self)

    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        hero.flap()
    }
   
    override func update(currentTime: CFTimeInterval) {
        self.hero.update()
    }
    
    
    func didBeginContact(contact: SKPhysicsContact!) {
    }
    
    func didEndContact(contact: SKPhysicsContact!)
    {
    }
    

}


