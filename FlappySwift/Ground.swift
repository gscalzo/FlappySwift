//
//  Ground.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 23/02/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//

import SpriteKit

class Ground {
    private var parallaxNode: ParallaxNode!
    private let textureName: String
    private let duration: Double
    
    init(textureNamed textureName: String, duration: Double) {
        parallaxNode = ParallaxNode(textureNamed: textureName)
        self.textureName = textureName
        self.duration = duration
    }
    
    @discardableResult
    func addTo(_ parentNode: SKSpriteNode) -> Self {
        parallaxNode.addTo(parentNode)
        return self
    }
}

// Startable
extension Ground: Startable {
    func start() {
        parallaxNode.start(duration: duration)
    }
    
    func stop() {
        parallaxNode.stop()
    }
}
