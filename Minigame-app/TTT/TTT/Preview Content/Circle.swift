//
//  Circle.swift
//  TTT
//
//  Created by Feliciano Medina on 4/12/25.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation
struct CircleGame: View {
    @State var score = 0
    @State var timeRemaining = 10
    @State var gameStarted = false
    @State var player1 = Player1()
    var playerName: String = "Guest"
    var audioPlayer: AVAudioPlayer?

    var body: some View {
        VStack {
            Text("Rules: Click on the circle to slow down the time")
                .font(.largeTitle)
                .foregroundColor(.red)
                .padding()
            Text("Score: \(score)")
                .font(.largeTitle)
                .padding()
            
            Text("Time Remaining: \(timeRemaining)")
                .font(.title)
                .padding()
            // get some style adding color
            Circle()
                .fill(Color.blue)
                .frame(width: 100, height: 100)
                .onTapGesture {
                    if gameStarted {
                        score += 1
                        playSound()
                    }
                }
                .padding()
            
            Button(action: startGame) {
                Text(gameStarted ? "Restart" : "Start Game")
                    .font(.title)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .onReceive(timer) { _ in
            if gameStarted {
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    gameStarted = false
                }
            }
        }
    }

    var timer: Publishers.Autoconnect<Timer.TimerPublisher> {
        Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
//starts our game and initializes it to 10 seconds whrn we start
    func startGame() {
        score = 0
        timeRemaining = 10
        gameStarted = true
    }
//function to play our sound
    func playSound() {
        guard let url = Bundle.main.url(forResource: "tap", withExtension: "mp3") else { return }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch {
            print("Error playing sound: \(error)")
        }
    }
}

struct CircleGameView_Previews: PreviewProvider {
    static var previews: some View {
        CircleGame()
    }
}
