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
    class func unarchiveFromFile(file : NSString) throws -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file as String, ofType: "sks") {
            let sceneData = try NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {
    private let skView = SKView()
    var gameCenter: GameCenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skView.frame = view.bounds
        view.addSubview(skView)
        createTheScene()
    }
    
    private func createTheScene() {
        do {
            let scene = try GameScene.unarchiveFromFile("GameScene")
            if let scene = scene as? GameScene {
                scene.size = skView.frame.size
                skView.showsFPS = true
                skView.showsNodeCount = true
                skView.ignoresSiblingOrder = true
                scene.scaleMode = .AspectFill
                
                scene.onPlayAgainPressed = {[weak self] in
                    self?.createTheScene()
                }
                
                scene.onCancelPressed = {[weak self] in
                    self?.dismissViewControllerAnimated(true, completion: nil)
                }
                skView.presentScene(scene)
            }
        }catch (let error) {
            fatalError("Error \(error) while unarchiving 'GameScene'")
        }
    }
}
