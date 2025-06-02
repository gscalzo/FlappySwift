//
//  GameScene.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 18/02/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//

import SpriteKit
import SIAlertView
import UIKit

enum BodyType: UInt32 {
    case bird   = 1  // (1 << 0)
    case ground = 2  // (1 << 1)
    case pipe   = 4  // (1 << 2)
    case gap    = 8  // (1 << 3)
}

class GameScene: SKScene {
    private var screenNode: SKSpriteNode!
    private var bird: Bird!
    private var actors: [Startable]!
    private var score = Score()
    var gameCenter: GameCenter?
    
    var onPlayAgainPressed: (() -> Void)!
    var onCancelPressed: (() -> Void)!
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -3)

        screenNode = SKSpriteNode(color: .clear, size: self.size)
        screenNode.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(screenNode)
        let sky = Background(textureNamed: "sky", duration: 60.0).addTo(screenNode, zPosition: 0)
        let city = Background(textureNamed: "city", duration: 20.0).addTo(screenNode, zPosition: 1)
        let ground = Background(textureNamed: "ground", duration: 5.0).addTo(screenNode, zPosition: 2)
        ground.zPosition(5)
        screenNode.addChild(bodyTextureName("ground"))
        bird = Bird(textureNames: ["bird1.png", "bird2.png"]).addTo(screenNode)
        bird.position = CGPoint(x: 30.0, y: 400.0)
        let pipes = Pipes(topPipeTexture: "topPipe.png", bottomPipeTexture: "bottomPipe").addTo(screenNode)
        score.addTo(screenNode)
        actors = [sky, city, ground, bird, pipes]
        for actor in actors {
            actor.start()
        }
    }
    override func update(_ currentTime: TimeInterval) {
        bird.update()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        run(SKAction.playSoundFileNamed("flap.wav", waitForCompletion: false))
        bird.flap()
    }
}
private extension GameScene {
    func bodyTextureName(_ textureName: String) -> SKNode {
        let image = UIImage(named: textureName)
        let width = image!.size.width
        let height = image!.size.height
        let groundBody = SKNode()
        groundBody.position = CGPoint(x: width/2, y: height/2)
        groundBody.physicsBody = SKPhysicsBody.rectSize(CGSize(width: width, height: height)) { body in
            body.isDynamic = false
            body.affectedByGravity = false
            body.categoryBitMask = BodyType.ground.rawValue
            body.collisionBitMask = BodyType.ground.rawValue
        }
        return groundBody
    }
}

// Contacts
extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        switch (contactMask) {
        case BodyType.pipe.rawValue |  BodyType.bird.rawValue:
            print("Contact with a pipe")
            run(SKAction.playSoundFileNamed("punch.wav", waitForCompletion: false))
            bird.pushDown()
        case BodyType.ground.rawValue | BodyType.bird.rawValue:
            print("Contact with ground")
            run(SKAction.playSoundFileNamed("punch.wav", waitForCompletion: false))
            for actor in actors {
                actor.stop()
            }
            let shakeAction = SKAction.shake(duration: 0.1, amplitudeX: 20, amplitudeY: 20)
            screenNode.run(shakeAction)
            if let gameCenter = gameCenter {
                gameCenter.reportScore(score: score.currentScore)
            }
            execAfter(delay: 1) {
                self.askToPlayAgain()
            }
        default:
            return
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        switch (contactMask) {
        case BodyType.gap.rawValue |  BodyType.bird.rawValue:
            print("Contact with gap")
            run(SKAction.playSoundFileNamed("yeah.mp3", waitForCompletion: false))
            score.increase()
        default:
            return
        }
    }
}

// Private
private extension GameScene {
    func askToPlayAgain() {
        let alertView = SIAlertView(title: "Ouch!!", andMessage: "Congratulations! Your score is \(score.currentScore). Play again?")
        alertView?.addButton(withTitle: "OK", type: .default, handler: { _ in self.onPlayAgainPressed() })
        alertView?.addButton(withTitle: "Cancel", type: .default, handler: { _ in self.onCancelPressed() })
        alertView?.show()
    }
}
