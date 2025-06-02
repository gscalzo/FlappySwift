//
//  GameViewController.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 18/02/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    private let skView = SKView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skView.frame = view.bounds
        view.addSubview(skView)
        skView.showsPhysics = true
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
