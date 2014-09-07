//
//  Pipes.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 29/08/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

class Pipes : Startable {
    private var parentNode: SKSpriteNode!
    private var createActionKey = "createActionKey"
    private let textures: [String]
    
    init(textures: [String]) {
        self.textures = textures
    }
    
    func addTo(parentNode: SKSpriteNode) -> Pipes {
        self.parentNode = parentNode
        return self
    }
    
    private func createNewPipe() {
        PipePair(textures: textures, centerY: centerPipes()).addTo(parentNode).start()
    }
    
    private func centerPipes() -> CGFloat {
        return parentNode.size.height/2 - 100 + 20 * CGFloat(arc4random_uniform(10))
    }
    
    func start() -> Startable {
        let createAction = SKAction.repeatActionForever(
            SKAction.sequence(
                [
                    SKAction.runBlock { () -> Void in
                        self.createNewPipe()
                    },
                    SKAction.waitForDuration(3)
                ]
            ) )
        
        parentNode.runAction(createAction, withKey: createActionKey)
        
        return self
    }
    
    func stop() -> Startable {
        parentNode.removeActionForKey(createActionKey)
        
        let pipeNodes = parentNode.children.filter { (node: AnyObject?) -> Bool in
             (node as SKNode).name == PipePair.kind
        }
        for pipe in pipeNodes {
            pipe.removeAllActions()
        }
        return self
    }
    
    
}