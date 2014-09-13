//
//  Pipes.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 29/08/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

class Pipes {
    // class let createActionKey = "createActionKey" // class variables not yet supported
    private class var createActionKey : String { get {return "createActionKey"} }

    private var parentNode: SKSpriteNode!
    private let textureNames: [String]
    
    init(textureNames: [String]) {
        self.textureNames = textureNames
    }
    
    func addTo(parentNode: SKSpriteNode) -> Pipes {
        self.parentNode = parentNode
        return self
    }
}

// Startable
extension Pipes : Startable {
    func start() -> Startable {
        let createAction = SKAction.repeatActionForever(
            SKAction.sequence(
                [
                    SKAction.runBlock {
                        self.createNewPipe()
                    },
                    SKAction.waitForDuration(3)
                ]
            ) )
        
        parentNode.runAction(createAction, withKey: Pipes.createActionKey)
        
        return self
    }
    
    func stop() -> Startable {
        parentNode.removeActionForKey(Pipes.createActionKey)
        
        let pipeNodes = parentNode.children.filter { (node: AnyObject?) -> Bool in
             (node as SKNode).name == PipePair.kind
        }
        for pipe in pipeNodes {
            pipe.removeAllActions()
        }
        return self
    }
}


extension Pipes {
    private func createNewPipe() {
        PipePair(textures: textureNames, centerY: centerPipes()).addTo(parentNode).start()
    }
    
    private func centerPipes() -> CGFloat {
        return parentNode.size.height/2 - 100 + 20 * CGFloat(arc4random_uniform(10))
    }
}
