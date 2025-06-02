//
//  MenuViewController.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 19/02/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//

import UIKit
import HTPressableButton

class MenuViewController: UIViewController {
    private let playButton = HTPressableButton(frame: CGRect(x: 0, y: 0, width: 260, height: 50), buttonStyle: .rect)!
    private let gameCenterButton = HTPressableButton(frame: CGRect(x: 0, y: 0, width: 260, height: 50), buttonStyle: .rect)!
    private var player: MusicPlayer?
    private let gameCenter = GameCenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameCenter.authenticateLocalPlayer()
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
private extension MenuViewController {
    func setup() {
        playButton.addTarget(self, action: #selector(onPlayPressed(_:)), for: .touchUpInside)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playButton)
        gameCenterButton.addTarget(self, action: #selector(onGameCenterPressed(_:)), for: .touchUpInside)
        gameCenterButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gameCenterButton)
    }
    
    @objc func onPlayPressed(_ sender: UIButton) {
        let vc = GameViewController()
        vc.gameCenter = gameCenter
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    
    @objc func onGameCenterPressed(_ sender: UIButton) {
        print("onGameCenterPressed")
        gameCenter.showLeaderboard()
    }
}

// MARK: Layout
extension MenuViewController {
    func layoutView() {
        // Play Button Constraints
        NSLayoutConstraint.activate([
            playButton.heightAnchor.constraint(equalToConstant: 80),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            playButton.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -60)
        ])
        // Game Center Button Constraints
        NSLayoutConstraint.activate([
            gameCenterButton.heightAnchor.constraint(equalToConstant: 80),
            gameCenterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameCenterButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            gameCenterButton.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 60)
        ])
    }
}

// MARK: Style
private extension MenuViewController {
    func style() {
        playButton.buttonColor = UIColor.ht_grapeFruit()
        playButton.shadowColor = UIColor.ht_grapeFruitDark()
        gameCenterButton.buttonColor = UIColor.ht_aqua()
        gameCenterButton.shadowColor = UIColor.ht_aquaDark()
    }
}

// MARK: Render
private extension MenuViewController {
    func render() {
        playButton.setTitle("Play", for: .normal)
        gameCenterButton.setTitle("Game Center", for: .normal)
    }
}


