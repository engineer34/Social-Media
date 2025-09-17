
//  GuessNumberView.swift
//  TTT
//  Created by Javier Medina on 3/10/25.

import SwiftUI

struct GuessNumberView: View {
    @State private var numbers=Int.random(in: 1...100)
    @State private var playerGuess = ""// Player Guesses
    
    @State private var count = 0 //Number of tries
    @State private var mes=""//displays message
    var playerName: String = "Guest" // Add this property

        var body: some View {
            VStack(spacing: 20) {
                Text("Guess a number from 1-100")
                    .font(.title)
                    .bold()
            
        
    TextField("Enter your guess", text: $playerGuess)
                   .textFieldStyle(RoundedBorderTextFieldStyle())
                   .keyboardType(.numberPad)
                   .padding()

               Button(action: checkGuess) {
                   Text("Check Guess")
                       .font(.headline)
                       .padding()
                       .frame(maxWidth: .infinity)
                       .background(Color.blue)
                       .foregroundColor(.white)
                       .cornerRadius(10)
               }

               Text(mes)
                   .font(.title2)
                   .foregroundColor(.red)
                   .bold()

               Text("Attempts: \(count)")
                   .font(.headline)
                   .foregroundColor(.gray)

               Button(action: resetGame) {
                   Text("🔄 Restart Game")
                       .font(.headline)
                       .padding()
                       .frame(maxWidth: .infinity)
                       .background(Color.red)
                       .foregroundColor(.white)
                       .cornerRadius(10)
               }
           }
           .padding()
       }

       func checkGuess() {
           if let guess = Int(playerGuess) {
               count += 1
               if guess == numbers {
                   mes = "🎉 Congratulations! You guessed it in \(count) tries!"
               } else if guess < numbers {
                   mes = "📉 Too low! Try again."
               } else {
                   mes = "📈 Too high! Try again."
               }
           } else {
               mes = "⚠️ Please enter a valid number"
           }
           playerGuess = "" // Clear input field after every attempt
       }

       func resetGame() {
           numbers = Int.random(in: 1...100)
           playerGuess = ""
           mes = ""
           count = 0
       }
   }

   struct GuessNumberView_Previews: PreviewProvider {
       static var previews: some View {
           GuessNumberView()
       }
   }
    
   
    


