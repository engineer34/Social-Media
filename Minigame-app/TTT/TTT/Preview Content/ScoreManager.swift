//
//  ScoreManager.swift
//  TTT
//
//  Created by Feliciano Medina on 2/28/25.
//

import Foundation
import CoreData
import UIKit

class ScoreManager {
    
    static let shared = ScoreManager()

    private let context = CoreDataManager.shared.context

    // Fetch all scores
    func fetchScores() -> [PlayerScore] {
        let fetchRequest: NSFetchRequest<PlayerScore> = PlayerScore.fetchRequest()
           
           do {
               let scores = try context.fetch(fetchRequest)
               print("Fetched scores: \(scores.map { "\($0.playerName ?? "Unknown") - \($0.score)" })")
               return scores
           } catch {
               print("Failed to fetch scores: \(error.localizedDescription)")
               return []
           }
    }

    // Update or add a player's score
    func updateScore(for playerName: String) {
        let fetchRequest: NSFetchRequest<PlayerScore> = PlayerScore.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "playerName == %@", playerName)

        do {
            let results = try context.fetch(fetchRequest)
            if let player = results.first {
                player.score += 1
            } else {
                let newPlayer = PlayerScore(context: context)
                newPlayer.playerName = playerName
                newPlayer.score = 1
            }
            CoreDataManager.shared.saveContext()
        } catch {
            print("Error updating score: \(error)")
        }
    }
}

