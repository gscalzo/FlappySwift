//
//  Background.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 26/08/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

class Background {
    private var parallaxNode: ParallaxNode!
    private let texture: String

    init(texture: String) {
        self.texture = texture
    }
    
    func addTo(parentNode: SKSpriteNode!) -> Background {
        let width = parentNode.size.width
        let height = parentNode.size.height
        
        parallaxNode = ParallaxNode(width: width,
            height: height,
            textureNamed: texture).addTo(parentNode)

        return self
    }
}

// Startable
extension Background : Startable {
    func start() -> Startable {
        parallaxNode.start(duration: 20.0)
        return self
    }
    
    func stop() -> Startable {
        parallaxNode.stop()
        return self
    }
}