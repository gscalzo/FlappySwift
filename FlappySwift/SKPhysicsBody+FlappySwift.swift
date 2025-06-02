//
//  SKPhysicsBody+FlappySwift.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 23/02/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//

import SpriteKit

extension SKPhysicsBody {
    typealias BodyBuilderClosure = (SKPhysicsBody) -> Void
    
    class func rectSize(_ size: CGSize,
        builderClosure: BodyBuilderClosure) -> SKPhysicsBody {
            let body = SKPhysicsBody(rectangleOf: size)
            builderClosure(body)
            return body
    }
}
