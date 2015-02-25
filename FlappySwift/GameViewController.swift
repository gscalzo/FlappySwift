//
//  GameViewController.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 18/02/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {
    private let skView = SKView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skView.frame = view.bounds
        view.addSubview(skView)
        createTheScene()
    }
    private func createTheScene() {
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            scene.size = skView.frame.size
//            skView.showsPhysics = true
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true
            scene.scaleMode = .AspectFill
            
            scene.onPlayAgainPressed = {[weak self] in
                self?.createTheScene()
                return
            }
            scene.onCancelPressed = {[weak self] in
                self?.dismissViewControllerAnimated(true, completion: nil)
                return
            }
            self.skView.presentScene(scene)
        }
    }    
}
