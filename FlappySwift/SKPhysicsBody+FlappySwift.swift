//
//  SKPhysicsBody+FlappySwift.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 10/09/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

extension SKPhysicsBody {
    typealias BodyBuilderClosure = (SKPhysicsBody) -> ()
    
    class func rectSize(size: CGSize,
                          builderClosure: BodyBuilderClosure) -> SKPhysicsBody {
        let body = SKPhysicsBody(rectangleOfSize: size)
        builderClosure(body)
        return body
    }
}