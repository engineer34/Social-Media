//
//  SKGame.swift
//  TTT
//
//  Created by Feliciano Medina on 3/22/25.

import SwiftUI
import SpriteKit

struct SKGameView: View {
    var playerName: String  // Add this property

    // Player name for score tracking
    
    var scene: SKScene {
        
        let scene = GameScene(size: CGSize(width: 390, height: 844)) // Adjust for device
        
        scene.scaleMode = .aspectFill
        scene.playerName = playerName // Pass player name
        return scene
    }

    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}
