//
//  Fire.swift
//  Rayo
//
//  Created by Feliciano Medina on 9/17/25.
//
import SwiftUI
import FirebaseSignInWithApple
import Rayo
@main
struct FirebaseSignInWithAppleDemoApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .configureFirebaseSignInWithApple
            (firestoreUserCollectionPath: Path.Firestore.profiles)
        }
    }
}
