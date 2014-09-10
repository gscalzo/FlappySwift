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

    override func didMoveToView(view: SKView) {
        
        screenNode = SKSpriteNode(color: UIColor.clearColor(), size: self.size)
        addChild(screenNode)        
        
        let bg = Background(textureNamed: "background").addTo(screenNode)
        let te = Ground(textureNamed: "ground").addTo(screenNode)
        actors = [bg, te]
        
        for actor in actors {
            actor.start()
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    }
}

