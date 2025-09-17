import SwiftUI

/*struct HighLowCardGameView: View {
    @State private var score = 0
    @State private var currentCardNumber = Int.random(in: 1...13)
    @State private var previousCardNumber = Int.random(in: 1...13)

    var body: some View {
        ZStack {
            // Set background texture
            Image("background_texture") // Ensure this is added in Assets.xcassets
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
                        Image(systemName: "arrow.up")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        Text("High")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }

                Spacer()

                // Card Display
                Image("card_\(currentCardNumber)") // Ensure images are named properly
                    .resizable()
                    .frame(width: 150, height: 200)
                    .shadow(radius: 5)

                Spacer()

                // Low Button
                Button(action: {
                    playLow()
                }) {
                    VStack {
                        Image(systemName: "arrow.down")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        Text("Low")
                            .font(.title)
                            .foregroundColor(.white)
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
    }

    func playHigh() {
        previousCardNumber = currentCardNumber
        currentCardNumber = Int.random(in: 1...13)

        if currentCardNumber > previousCardNumber {
            score += 1
        } else {
            score -= 1
        }
    }

    func playLow() {
        previousCardNumber = currentCardNumber
        currentCardNumber = Int.random(in: 1...13)

        if currentCardNumber < previousCardNumber {
            score += 1
        } else {
            score -= 1
        }
    }
}

struct HighLowCardGameView_Previews: PreviewProvider {
    static var previews: some View {
        HighLowCardGameView()
    }
}
*/
