//
//  GameCenter.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 07/03/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//
import GameKit
import SIAlertView
import UIKit

class GameCenter: NSObject {
    private var gameCenterEnabled = false
    private var leaderboardIdentifier = ""
    
    func authenticateLocalPlayer() {
        let localPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = { [weak self] (viewController, error) in
            if let vc = viewController {
                let topViewController = UIApplication.shared.delegate!.window!?.rootViewController
                topViewController?.present(vc, animated: true, completion: nil)
            } else if localPlayer.isAuthenticated {
                self?.gameCenterEnabled = true
                localPlayer.loadDefaultLeaderboardIdentifier { leaderboardIdentifier, error in
                    if let leaderboardIdentifier = leaderboardIdentifier {
                        self?.leaderboardIdentifier = leaderboardIdentifier
                    }
                }
            }
        }
    }
    
    func reportScore(score: Int) {
        if !gameCenterEnabled {
            return
        }
        let gkScore = GKScore(leaderboardIdentifier: leaderboardIdentifier)
        gkScore.value = Int64(score)
        GKScore.report([gkScore], withCompletionHandler: nil)
    }
    
    func showLeaderboard() {
        if !gameCenterEnabled {
            let alertView = SIAlertView(title: "Game Center Unavailable", andMessage: "Player is not signed in")
            alertView?.addButton(withTitle: "OK", type: .default, handler: { _ in })
            alertView?.show()
            return
        }
        let gcViewController = GKGameCenterViewController()
        gcViewController.gameCenterDelegate = self
        gcViewController.viewState = .leaderboards
        gcViewController.leaderboardIdentifier = leaderboardIdentifier
        let topViewController = UIApplication.shared.delegate!.window!?.rootViewController
        topViewController?.present(gcViewController, animated: true, completion: nil)
    }
}

extension GameCenter: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
