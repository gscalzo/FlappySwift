//
//  SKEmitterNode+FlappySwift.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 07/09/2014.
//  Copyright (c) 2014 Effective Code. All rights reserved.
//

import SpriteKit

// from https://developer.apple.com/library/prerelease/ios/samplecode/Adventure-Swift/Listings/Adventure_Adventure_Shared_Utilities_GraphicsUtilities_swift.html#//apple_ref/doc/uid/TP40014639-Adventure_Adventure_Shared_Utilities_GraphicsUtilities_swift-DontLinkElementID_19

extension SKEmitterNode {
//    class func emitterNodeWithName(name: String) -> SKEmitterNode {
//        return NSKeyedUnarchiver.unarchiveObjectWithFile(NSBundle.mainBundle().pathForResource(name, ofType: "sks")!) as SKEmitterNode
//    }
    
    class func emitterNodeWithName(name : NSString) -> SKEmitterNode
    {
        let path = NSBundle.mainBundle().pathForResource(name, ofType: "sks")
        
        var sceneData = NSData.dataWithContentsOfFile(path!, options: .DataReadingMappedIfSafe, error: nil)
        var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
        
        archiver.setClass(SKEmitterNode.self, forClassName: "SKEditorScene")
        let node = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as SKEmitterNode?
        archiver.finishDecoding()
        return node!
    }
}