//
//  ParallaxNode.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 26/08/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

class ParallaxNode {
    private let node: SKSpriteNode
    
    init(textureNamed: String) {
        let leftHalf = createHalfNodeTexture(textureNamed: textureNamed, offsetX: 0)
        let rightHalf = createHalfNodeTexture(textureNamed: textureNamed, offsetX: leftHalf.size.width)
        
        let size = CGSize(width: leftHalf.size.width + rightHalf.size.width,
            height: leftHalf.size.height)
        
        node = SKSpriteNode(color: .clear, size: size)
        node.anchorPoint = .zero
        node.position = .zero
        node.addChild(leftHalf)
        node.addChild(rightHalf)
    }
    
    @discardableResult
    func zPosition(_ zPosition: CGFloat) -> ParallaxNode {
        node.zPosition = zPosition
        return self
    }
    
    @discardableResult
    func addTo(_ parentNode: SKSpriteNode, zPosition: CGFloat = 0) -> ParallaxNode {
        parentNode.addChild(node)
        node.zPosition = zPosition
        return self
    }
}

// MARK: Startable
extension ParallaxNode: Startable {
    func start(duration: TimeInterval) {
        node.run(SKAction.repeatForever(SKAction.sequence(
            [
                SKAction.moveTo(x: -node.size.width/2.0, duration: duration),
                SKAction.moveTo(x: 0, duration: 0)
            ]
            )))
    }
    
    func stop() {
        node.removeAllActions()
    }
}

// MARK: Private
private func createHalfNodeTexture(textureNamed: String, offsetX: CGFloat) -> SKSpriteNode {
    let node = SKSpriteNode(imageNamed: textureNamed, normalMapped: true)
    node.anchorPoint = .zero
    node.position = CGPoint(x: offsetX, y: 0)
    return node
}