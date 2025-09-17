import CoreData
import Foundation

class GameDataModel {
    
    static let shared = GameDataModel()
       private let viewContext = PersistenceController.shared.context

       func updateScore(for playerName: String) {
           let fetchRequest: NSFetchRequest<PlayerScore> = PlayerScore.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "playerName == %@", playerName)

           do {
               let results = try viewContext.fetch(fetchRequest)
               let player = results.first ?? PlayerScore(context: viewContext)
               player.playerName = playerName
               player.score += 1
               try viewContext.save()
           } catch {
               print("Failed to update score: \(error)")
           }
       }
   }
