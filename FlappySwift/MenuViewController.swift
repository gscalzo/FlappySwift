//
//  MenuViewController.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 19/02/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//

import UIKit
import HTPressableButton
import Cartography

class MenuViewController: UIViewController {
    private let playButton = HTPressableButton(frame: CGRectMake(0, 0, 260, 50), buttonStyle: .Rect)
    private let gameCenterButton = HTPressableButton(frame: CGRectMake(0, 0, 260, 50), buttonStyle: .Rect)
    private var player: MusicPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
             player = try MusicPlayer(filename: "Pamgaea", type: "mp3")
             player!.play()
        } catch {
            print("Error playing soundtrack")
        }
        
        setup()
        layoutView()
        style()
        render()
    }
}

// MARK: Setup
private extension MenuViewController{
    func setup(){
        playButton.addTarget(self, action: "onPlayPressed:", forControlEvents: .TouchUpInside)
        view.addSubview(playButton)
        gameCenterButton.addTarget(self, action: "onGameCenterPressed:", forControlEvents: .TouchUpInside)
        view.addSubview(gameCenterButton)
    }
    
    @objc func onPlayPressed(sender: UIButton) {
        let vc = GameViewController()
        vc.modalTransitionStyle = .CrossDissolve
        presentViewController(vc, animated: true, completion: nil)
    }
    
    @objc func onGameCenterPressed(sender: UIButton) {
        print("onGameCenterPressed")
    }
    
}

// MARK: Layout
extension MenuViewController{
    func layoutView() {
        constrain(playButton) { view in
            view.bottom == view.superview!.centerY - 60
            view.centerX == view.superview!.centerX
            view.height == 80
            view.width == view.superview!.width - 40
        }
        constrain(gameCenterButton) { view in
            view.bottom == view.superview!.centerY + 60
            view.centerX == view.superview!.centerX
            view.height == 80
            view.width == view.superview!.width - 40
        }
    }
}


// MARK: Style
private extension MenuViewController{
    func style(){
        playButton.buttonColor = UIColor.ht_grapeFruitColor()
        playButton.shadowColor = UIColor.ht_grapeFruitDarkColor()
        gameCenterButton.buttonColor = UIColor.ht_aquaColor()
        gameCenterButton.shadowColor = UIColor.ht_aquaDarkColor()
    }
}

// MARK: Render
private extension MenuViewController{
    func render(){
        playButton.setTitle("Play", forState: .Normal)
        gameCenterButton.setTitle("Game Center", forState: .Normal)
    }
}


