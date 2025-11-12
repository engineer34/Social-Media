import SwiftUI

// Custom view modifier to round specific corners
extension View {
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

// Shape define which corners to round up
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
// function path to help rounf corners
    // this whole file is chatgpt helper file since I kept getting errors for the .bottomleft and .bottomright 
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
// these are extensions fior int to help with large numbers with abbreviations
extension Int {
    func formattedString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        
        let thousand = 1000
        let million = thousand * thousand
        
        if self >= million {
            let formattedNumber = Double(self) / Double(million)
            return "\(formatter.string(from: NSNumber(value: formattedNumber)) ?? "")M" // Format number in millions
        } else if self >= thousand {
            let formattedNumber = Double(self) / Double(thousand)
            return "\(formatter.string(from: NSNumber(value: formattedNumber)) ?? "")K" // Format number in thousands
        } else {
            return "\(self)" // Return the number as is
        }
    }
}
//
//  Fire.swift
//  Rayo
//
//  Created by Feliciano Medina on 9/17/25.
//
/*import SwiftUI
import FirebaseAuth
import AuthenticationServices
//import Rayo
import FirebaseCore

struct FirebaseSignInWithAppleDemoApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .configureFirebaseSignInWithApple
            (firestoreUserCollectionPath: Path.Firestore.profiles)
        }
    }
}
*/
