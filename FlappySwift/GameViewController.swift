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
    class func unarchiveFromFile(_ file: String) throws -> SKNode? {
        if let path = Bundle.main.path(forResource: file, ofType: "sks") {
            let sceneData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let archiver = try NSKeyedUnarchiver(forReadingFrom: sceneData)
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! GameScene
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
                scene.scaleMode = .aspectFill
                
                scene.onPlayAgainPressed = { [weak self] in
                    self?.createTheScene()
                }
                
                scene.onCancelPressed = { [weak self] in
                    self?.dismiss(animated: true, completion: nil)
                }
                skView.presentScene(scene)
            }
        } catch {
            fatalError("Error \(error) while unarchiving 'GameScene'")
        }
    }
}
