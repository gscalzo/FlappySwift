//
//  MenuViewController.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 19/02/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    private let playButton = FSPressableButton(frame: CGRect(x: 0, y: 0, width: 260, height: 50), style: .grapefruit)
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
private extension MenuViewController {
    func setup() {
        playButton.addTarget(self, action: #selector(onPlayPressed(_:)), for: .touchUpInside)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playButton)
    }
    
    @objc func onPlayPressed(_ sender: UIButton) {
        let vc = GameViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
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
    }
}

// MARK: Style
private extension MenuViewController {
    func style() {
        playButton.setTitle("Play", for: .normal)
    }
}

// MARK: Render
private extension MenuViewController {
    func render() {
        playButton.setTitle("Play", for: .normal)
    }
}


