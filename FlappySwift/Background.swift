//
//  Background.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 26/08/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

class Background {
    private let parallaxNode: ParallaxNode
    private let duration: Double
    
    func zPosition(zPosition: CGFloat) {
        parallaxNode.zPosition(zPosition)
    }
    
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
extension Background : Startable {
    func start() {
        parallaxNode.start(duration: duration)
    }
    
    func stop() {
        parallaxNode.stop()
    }
}