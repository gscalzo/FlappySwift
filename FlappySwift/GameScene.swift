//
//  GameScene.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 02/06/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    private var screenNode: SKSpriteNode!
    private var actors: [Startable]!
    private var bird: Bird!

    override func didMoveToView(view: SKView) {
        physicsWorld.gravity = CGVector(dx: 0, dy: -3)

        screenNode = SKSpriteNode(color: UIColor.clearColor(), size: self.size)
        addChild(screenNode)        
        
        let bg = Background(textureNamed: "background").addTo(screenNode)
        let te = Ground(textureNamed: "ground").addTo(screenNode)
        bird = Bird(textureNames: ["bird1", "bird2"]).addTo(screenNode)
        bird.position = CGPointMake(30.0, 400.0)

        actors = [bg, te, bird]
        
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

