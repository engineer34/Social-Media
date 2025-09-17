import SwiftUI

struct HighLowCardGameView: View {
var playerName: String = "Guest" // Add this property
    @State private var score = 0
    @State private var currentCardNumber = 1
    @State private var previousCardNumber = 1
    @State private var suitNumber = 1
    @State private var cardImageName = "card_1_1" // Default card image name
  

    var body: some View {
        ZStack {
            // Background image
            Image("green_background") // Ensure this image is in Assets.xcassets
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                Spacer()
                // High Button
                Button(action: {
                    playHigh()
                }) {
                    VStack {
                        Image("high")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                                            }
                }
                
                Spacer()
          //  VStack {
             //   Spacer()
                
                // Card Display
                Image(cardImageName)
                    .resizable()
                    .frame(width: 150, height: 200)
                    .shadow(radius: 5)
                
                Spacer()
                // Low Button
                Button(action: {
                    playLow()
                }) {
                    VStack {
                        Image("low")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                       
                    }
                }
                
                Spacer()
                
                // Score Display
                Text("Score: \(score)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                
                Spacer()
            }
        }
        .onAppear {
            randomCard() // Initialize first card when view appears
        }
    }

    // Generates a new random card
    func randomCard() {
        previousCardNumber = currentCardNumber
        suitNumber = Int.random(in: 1...4) // Random suit (1-4)
        currentCardNumber = Int.random(in: 1...13) // Random card (1-13)
        
        cardImageName = "card_\(suitNumber)_\(currentCardNumber)" // Update card image name
    }

    // Player chooses "High"
    func playHigh() {
        randomCard()
        if currentCardNumber > previousCardNumber {
            score += 1
        } else if currentCardNumber < previousCardNumber {
            score -= 1
        }
    }

    // Player chooses "Low"
    func playLow() {
        randomCard()
        if currentCardNumber > previousCardNumber {
            score -= 1
        } else if currentCardNumber < previousCardNumber {
            score += 1
        }
    }
}

struct HighLowCardGameView_Previews: PreviewProvider {
    static var previews: some View {
        HighLowCardGameView()
    }
}

