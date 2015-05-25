//
//  Ground.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 23/02/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//

import SpriteKit

class Ground  {
    private var parallaxNode: ParallaxNode!
    private let textureName: String
    
//    init(textureNamed textureName: String, duration: Double) {
//        self.textureName = textureName
//    }
//    
//    func addTo(parentNode: SKSpriteNode!) -> Ground {
//        let width = parentNode.size.width
//        let height = CGFloat(60.0)
//        
//        parallaxNode = ParallaxNode(textureNamed: textureName).zPosition(5).addTo(parentNode)
//        return self
//    }
    
    init(textureNamed textureName: String, duration: Double) {
        parallaxNode = ParallaxNode(textureNamed: textureName)
        self.duration = duration
    }
    
    func addTo(parentNode: SKSpriteNode) -> Self {
        parallaxNode.addTo(parentNode)
        return self
    }
}

// Startable
extension Ground : Startable {
    func start() {
        parallaxNode.start(duration: duration)
    }
    
    func stop() {
        parallaxNode.stop()
    }
}
