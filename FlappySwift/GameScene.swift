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
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -3)
        
        Background().addTo(self).start()
        Terrain().addTo(self).start()
        Pipes().addTo(self).start()

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


