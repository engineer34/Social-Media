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
