//
//  ContentView.swift
//  TTT
//
//  Created by Feliciano Medina on 2/15/25.
//

import SwiftUI

struct TicTacToeView: View {
    var playerName: String = "Guest" // Add this property
    @ObservedObject var TicTacToe = TicTacModel()
    @Environment(\.managedObjectContext) private var viewContext
    /*@State private var board: [String] = Array(repeating: "", count: 9)
     @State private var currentPlayer = "X"*/
    @FetchRequest(
        entity: PlayerScore.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \PlayerScore.score, ascending: false)]
    ) var playerScores: FetchedResults<PlayerScore>
    @State private var showWinnerAlert = false
    @State private var winnerName: String = ""


    
    var body: some View {
        VStack {
            Text("Tic Tac Toe")
                .font(.system(size: 45, weight: .heavy))
                .padding()
            
            // Display player scores
            Text("Leaderboard")
                .font(.title2)
                .padding()
            
            List(playerScores, id: \.self) { player in
                HStack {
                    Text(player.playerName ?? "Unknown")
                    Spacer()
                    Text("\(player.score)")
                }
            }
            let col = Array(repeating: GridItem(.flexible()), count: 3)
            
            LazyVGrid(columns: col, spacing: 10) {
                ForEach(0..<9, id: \.self) { i in
                    Button(action: {
                        TicTacToe.buttonTap(i: i)
                        
                    }, label: {
                        Text(TicTacToe.buttonLbl(i: i))
                        
                            .frame(width: 100, height: 100)
                            .background(Color.gray)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    })
                }
            }
            .padding(.bottom)
            
            Button(action: {
                TicTacToe.resetGame()
                
            }, label: {
                Text("Restart Game")
                    .font(.system(size: 20, weight: .heavy))
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.red)
                    .clipShape(Capsule())
            })
        }
        .padding()
        .alert(isPresented: $showWinnerAlert) {
            Alert(title: Text("Game Over"),
                  message: Text("\(winnerName) Wins!"),
                  dismissButton: .default(Text("OK")))
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToeView()
    }
}
