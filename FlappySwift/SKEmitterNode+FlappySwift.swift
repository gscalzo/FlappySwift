//
//  SKEmitterNode+FlappySwift.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 07/09/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

extension SKEmitterNode {
    class func emitterNodeWithName(name : NSString) -> SKEmitterNode
    {
        let path = NSBundle.mainBundle().pathForResource(name, ofType: "sks")
        
        var sceneData = NSData(contentsOfFile: path!, options: .DataReadingMappedIfSafe, error: nil)
        var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData!)
        
        archiver.setClass(SKEmitterNode.self, forClassName: "SKEditorScene")
        let node = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as SKEmitterNode?
        archiver.finishDecoding()
        return node!
    }
}