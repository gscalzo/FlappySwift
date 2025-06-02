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
    class func unarchiveFromFile(_ file: String) throws -> GameScene? {
        if let path = Bundle.main.path(forResource: file, ofType: "sks") {
            let sceneData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let archiver = try NSKeyedUnarchiver(forReadingFrom: sceneData)
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let decoded = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey)
            archiver.finishDecoding()
            if let scene = decoded as? GameScene {
                print("[GameViewController] Successfully decoded a GameScene from SKS.")
                return scene
            } else {
                print("[GameViewController] Decoded object from SKS is not a GameScene. Actual type: \(type(of: decoded))")
                let mirror = Mirror(reflecting: decoded as Any)
                print("[GameViewController] Properties of decoded object:")
                for child in mirror.children {
                    if let label = child.label {
                        print("  \(label): \(child.value)")
                    } else {
                        print("  (no label): \(child.value)")
                    }
                }
                return nil
            }
        } else {
            print("[GameViewController] Could not find SKS file named \(file).sks in bundle.")
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
        let scene = GameScene(size: skView.frame.size)
        scene.scaleMode = .aspectFill
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        
        scene.onPlayAgainPressed = { [weak self] in
            self?.createTheScene()
        }
        
        scene.onCancelPressed = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        skView.presentScene(scene)
    }
}
