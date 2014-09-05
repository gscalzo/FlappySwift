//
//  Pipes.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 29/08/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

class Pipes {
    var parentNode: SKScene!
    
    init() {        
    }
    
    func addTo(parentNode: SKScene!) -> Pipes {
        self.parentNode = parentNode
        return self
    }
    
    func start() {
        parentNode.runAction(
            SKAction.repeatActionForever(
                SKAction.sequence(
                    [
                        SKAction.runBlock({ () -> Void in
                            self.createNewPipe()
                        }),
                        SKAction.waitForDuration(3)
                    ]
                )))
    }
    
    private func createNewPipe() {
        PipePair(centerY: centerPipes()).addTo(parentNode).start()
    }
    
    private func centerPipes() -> CGFloat {
        return parentNode.size.height/2 - 100 + 20 * CGFloat(arc4random_uniform(10))
    }
}