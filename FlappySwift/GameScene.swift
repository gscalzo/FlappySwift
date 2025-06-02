//
//  GameScene.swift
//  FlappySwift
//
//  Created by Giordano Scalzo on 18/02/2015.
//  Copyright (c) 2015 Effective Code. All rights reserved.
//

import SpriteKit
import UIKit

class GameScene: SKScene {
    private var screenNode: SKSpriteNode!
    private var bird: Bird!
    private var actors: [Startable]!
    private var score = Score()
    
    var onPlayAgainPressed: (() -> Void)!
    var onCancelPressed: (() -> Void)!

    // Debug flag to hide background for better physics debug visibility
    var hideBackgroundForDebug: Bool = false

    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -3)

        screenNode = SKSpriteNode(color: .clear, size: self.size)
        screenNode.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(screenNode)

        var actorsList: [Startable] = []
        if !hideBackgroundForDebug {
            // Add sky color fill at the top
            let skyColor = UIColor(red: 143.0/255.0, green: 233.0/255.0, blue: 227.0/255.0, alpha: 1.0) // #8FE9E3
            let skyFill = SKSpriteNode(color: skyColor, size: CGSize(width: self.size.width, height: self.size.height))
            skyFill.anchorPoint = CGPoint(x: 0, y: 0)
            skyFill.position = CGPoint(x: 0, y: 0)
            skyFill.zPosition = -2
            screenNode.addChild(skyFill)

            // Add ground color fill at the bottom
            let groundColor = UIColor(red: 164.0/255.0, green: 121.0/255.0, blue: 65.0/255.0, alpha: 1.0) // #A47941
            let groundFillHeight: CGFloat = 80
            let groundFill = SKSpriteNode(color: groundColor, size: CGSize(width: self.size.width, height: groundFillHeight))
            groundFill.anchorPoint = CGPoint(x: 0, y: 0)
            groundFill.position = CGPoint(x: 0, y: 0)
            groundFill.zPosition = 9
            screenNode.addChild(groundFill)

            // Move backgrounds up by 40 points
            let backgroundYOffset: CGFloat = 40
            let sky = Background(textureNamed: "sky", duration: 60.0)
            sky.zPosition(0)
            sky.addTo(screenNode, zPosition: 0)
            sky.parallaxNodePositionYOffset(backgroundYOffset)
            actorsList.append(sky)

            let city = Background(textureNamed: "city", duration: 20.0)
            city.zPosition(1)
            city.addTo(screenNode, zPosition: 1)
            city.parallaxNodePositionYOffset(backgroundYOffset)
            actorsList.append(city)

            let ground = Background(textureNamed: "ground", duration: 5.0)
            ground.zPosition(10)
            ground.addTo(screenNode, zPosition: 10)
            ground.parallaxNodePositionYOffset(backgroundYOffset)
            actorsList.append(ground)
        }

        screenNode.addChild(bodyTextureName("ground"))
        bird = Bird(textureNames: ["bird1.png", "bird2.png"]).addTo(screenNode)
        bird.position = CGPoint(x: 30.0, y: 400.0)
        let pipes = Pipes(topPipeTexture: "topPipe.png", bottomPipeTexture: "bottomPipe").addTo(screenNode)
        // Ensure all pipes are below the ground
        for child in screenNode.children {
            if child.name == "PIPES" {
                child.zPosition = 5
            }
        }
        score.addTo(screenNode)
        actors = actorsList + [bird, pipes]
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
        AlertWrapper.showAlertWithActionsOnTop(
            title: "Ouch!!",
            message: "Congratulations! Your score is \(score.currentScore). Play again?",
            actions: [
                AlertWrapper.Action(title: "OK", style: .default, handler: { [weak self] in self?.onPlayAgainPressed() }),
                AlertWrapper.Action(title: "Cancel", style: .cancel, handler: { [weak self] in self?.onCancelPressed() })
            ]
        )
    }
}
