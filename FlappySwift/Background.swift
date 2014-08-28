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
    
    init() {
    }
    
    func addTo(parentNode: SKScene!) -> Background {
        let width = parentNode.size.width
        let height = parentNode.size.height
        
        parallaxNode = ParallaxNode(width: width,
            height: height,
            textureNamed: "background.png").addTo(parentNode)

        return self
    }
    
    func start() {
        parallaxNode.start(duration: 20.0)
    }
}
