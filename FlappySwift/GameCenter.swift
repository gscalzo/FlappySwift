//
//  GameCenter.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 07/03/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//
import GameKit
import SIAlertView

class GameCenter: NSObject {
    private var gameCenterEnabled = false
    private var leaderboardIdentifier = ""
    
    func authenticateLocalPlayer() {
        let localPlayer = GKLocalPlayer.localPlayer()
        localPlayer.authenticateHandler = { (viewController, error) in
            if let vc = viewController {
                let topViewController = UIApplication.sharedApplication().delegate!.window!!.rootViewController
                topViewController?.presentViewController(vc, animated: true, completion: nil)
            } else if localPlayer.authenticated {
                self.gameCenterEnabled = true
                localPlayer.loadDefaultLeaderboardIdentifierWithCompletionHandler({ (leaderboardIdentifier, error) -> Void in
                    self.leaderboardIdentifier = leaderboardIdentifier
                })
            }
        }
    }
    
    func reportScore(score: Int){
        if !gameCenterEnabled {
            return
        }
        
        let gkScore = GKScore(leaderboardIdentifier: leaderboardIdentifier)
        gkScore.value = Int64(score)
        
        GKScore.reportScores([gkScore], withCompletionHandler: nil)
    }
    
    
    func showLeaderboard() {
        if !gameCenterEnabled {
            let alertView = SIAlertView(title: "Game Center Unavailable", andMessage: "Player is not signed in")
            
            alertView.addButtonWithTitle("OK", type: .Default) { _ in  }
            alertView.show()
            return
        }
        
        
        let gcViewController = GKGameCenterViewController()
        
        gcViewController.gameCenterDelegate = self
        gcViewController.viewState = .Leaderboards
        gcViewController.leaderboardIdentifier = leaderboardIdentifier
        
        let topViewController = UIApplication.sharedApplication().delegate!.window!!.rootViewController
        topViewController?.presentViewController(gcViewController, animated: true, completion: nil)
    }
}

extension GameCenter: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController){
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
