//
//  SKAction+FlappySwift.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 07/03/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//

import SpriteKit

extension SKAction {
    // Thanks to Benzi: http://stackoverflow.com/a/24769521/288379
    class func shake(duration:CGFloat, amplitudeX:Int = 3, amplitudeY:Int = 3) -> SKAction {
        let numberOfShakes = duration / 0.015 / 2.0
        var actionsArray:[SKAction] = []
        for _ in 1...Int(numberOfShakes) {
            let dx = CGFloat(arc4random_uniform(UInt32(amplitudeX))) - CGFloat(amplitudeX / 2)
            let dy = CGFloat(arc4random_uniform(UInt32(amplitudeY))) - CGFloat(amplitudeY / 2)
            let forward = SKAction.moveByX(dx, y:dy, duration: 0.015)
            let reverse = forward.reversedAction()
            actionsArray.append(forward)
            actionsArray.append(reverse)
        }
        return SKAction.sequence(actionsArray)
    }
}