
//  TTTApp.swift
//Source:https://www.youtube.com/watch?v=E-iOBThxIAk
//Source:https://www.youtube.com/watch?v=jUMUfdKVYmI
//Source:https://www.youtube.com/watch?v=jLRNgR8nw-k
//Source:for HighLowCardGame maxwells version
//Source: for GuessNumberView saw several examples from stackoverflow built code bits from a ton of examples
import SwiftUI

struct MainMenuView: View {
    @State private var playerName = "Player1" // Add a default player name
    var body: some View {
        NavigationView {
            VStack {
                Text("Mini Games")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                List {
                    // My tictactoe view navigation link
                    NavigationLink(destination: TicTacToeView(playerName: playerName)) {
                        Text("Play Tic-Tac-Toe")
                    }
                    // my card game nav
                    
                    NavigationLink(destination: HighLowCardGameView(playerName: playerName)){
                        Text("Play High-Low Card")
                    }
                    // My guessing number game
                    
                    NavigationLink(destination: GuessNumberView(playerName: playerName)){
                        Text("Play Guess-Number")
                    }
                    // My SKGame that has a character that moves
                    NavigationLink(destination: SKGameView(playerName: playerName)){
                        Text("Play Character Game")
                    }
                    // Dot game here
                    NavigationLink(destination: DotGameView(playerName: playerName)) {
                        Text("Play Dot")
                    }
                    NavigationLink(destination: CircleGame(playerName: playerName)){
                        Text("Play Circle Game")
                    }

                    // Add more mini-games here
                    NavigationLink(destination: Text("Will be coming soon....")) {
                        Text("Other Mini-Games")
                    }
                    
                    
                }
            }
        }
    }
}
@main
struct TTTApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
            WindowGroup {
                MainMenuView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
