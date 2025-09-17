//
//  GameScene.swift
//  TTT
//
//  Created by Feliciano Medina on 3/22/25.
//

import Foundation
import SpriteKit
import UIKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    var player: SKSpriteNode!
    var ground: SKSpriteNode!
    var obstacleTimer: Timer?
    var score = 0
    var scoreLabel: SKLabelNode!
    
    var playerName: String = "Player1" // Default name (updated from SwiftUI)

    let playerCategory: UInt32 = 0x1 << 0
    let obstacleCategory: UInt32 = 0x1 << 1
    let groundCategory: UInt32 = 0x1 << 2
    
    override func didMove(to view: SKView) {
        self.scaleMode = .resizeFill
        physicsWorld.contactDelegate = self
        self.backgroundColor = .white  // Change to a lighter color for visibility
        self.isUserInteractionEnabled = true  // Enable keyboard interaction
               
        if let skView = self.view {
            skView.showsPhysics = true
            skView.showsNodeCount = true
            skView.showsFPS = true
        }
        
        createGround()
        createPlayer()
        
        createScoreLabel()
        startSpawningObstacles()
    }
    func createGround() {
        ground = SKSpriteNode(color: .brown, size: CGSize(width: self.size.width, height: 20))
        ground.position = CGPoint(x: 0, y: -self.size.height / 3)
        
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.categoryBitMask = groundCategory
        
        addChild(ground)
    }
    
    func createPlayer() {
        player = SKSpriteNode(imageNamed: "playerImage")
        player.position = CGPoint(x: -self.size.width / 4, y: ground.position.y + 50)
        
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.collisionBitMask = groundCategory
        player.physicsBody?.contactTestBitMask = obstacleCategory
        player.physicsBody?.affectedByGravity = true
        
        self.addChild(player)
    }
    
    
    func createScoreLabel() {
        scoreLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = .black
        scoreLabel.position = CGPoint(x: 0, y: self.size.height / 2 - 100)
        scoreLabel.text = "Score: 0"
        
        addChild(scoreLabel)
    }
    
    func startSpawningObstacles() {
        let spawn = SKAction.run(spawnObstacle)
            let delay = SKAction.wait(forDuration: 2.0) // Adjust spawn rate
            let sequence = SKAction.sequence([spawn, delay])
            let repeatAction = SKAction.repeatForever(sequence)
            self.run(repeatAction)
    }
    
    @objc func spawnObstacle() {
        let obstacle = SKSpriteNode(imageNamed: "obstacleImage")
        obstacle.position = CGPoint(x: self.size.width / 2, y: ground.position.y + 50)
        
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
        obstacle.physicsBody?.categoryBitMask = obstacleCategory
        obstacle.physicsBody?.affectedByGravity = false
        obstacle.physicsBody?.velocity = CGVector(dx: -200, dy: 0)
        obstacle.physicsBody?.contactTestBitMask = playerCategory
        obstacle.physicsBody?.isDynamic = true
        addChild(obstacle)
        let moveAction = SKAction.moveBy(x: -self.size.width, y: 0, duration: 3.0)
            let removeAction = SKAction.removeFromParent()
            obstacle.run(SKAction.sequence([moveAction, removeAction]))
        // Increase score for dodging an obstacle
        score += 1
        scoreLabel.text = "Score: \(score)"
        
        // Save new high score
        ScoreManager.shared.updateScore(for: playerName)
    }
    
    func jump() {
        if player.position.y <= ground.position.y + 21, let physicsBody = player.physicsBody {
            physicsBody.applyImpulse(CGVector(dx: 0, dy: 300))
            physicsBody.velocity.dy = 300 // Ensure the velocity gets updated
        }
    }
    func roll() {
        let shrinkAction = SKAction.scaleY(to: 0.5, duration: 0.2)
        let restoreAction = SKAction.scaleY(to: 1.0, duration: 0.5)
        player.run(SKAction.sequence([shrinkAction, SKAction.wait(forDuration: 0.5), restoreAction]))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        jump()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            let previousLocation = touch.previousLocation(in: self)
            
            if touchLocation.y < previousLocation.y {
                roll()
            }
        }
    }
    override var canBecomeFirstResponder: Bool {
            return true
        }

        override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
            guard let key = presses.first?.key else { return }
            
            switch key.keyCode {
            case .keyboardSpacebar:
                jump()
            case .keyboardDownArrow:
                roll()
            default:
                break
            }
        }
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == (playerCategory | obstacleCategory) {
            gameOver()
        }
    }
    
    func gameOver() {
        obstacleTimer?.invalidate()
        player.removeFromParent()
        print("Game Over!")
    }
}
