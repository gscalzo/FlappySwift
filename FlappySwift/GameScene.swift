//
//  GameScene.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 18/02/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    private var screenNode: SKSpriteNode!
    private var actors: [Startable]!

    override func didMoveToView(view: SKView) {
        screenNode = SKSpriteNode(color: UIColor.clearColor(), size: self.size)
        addChild(screenNode)
        let sky = Background(textureNamed: "sky", duration:60.0).addTo(screenNode)
        let city = Background(textureNamed: "city", duration:20.0).addTo(screenNode)
        let ground = Background(textureNamed: "ground", duration:5.0).addTo(screenNode)
        actors = [sky, city, ground]
        
        for actor in actors {
            actor.start()
        }
    }
}
