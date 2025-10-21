//
//  App.swift
//  Rayo
//
//  Created by Feliciano Medina on 9/17/25.
//
import SwiftUI
import FirebaseCore
//helps perform set up tasks
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        //initializes firebase when the app starts
        // helps me use features like Authentication, Firestore, or realtime Database
        FirebaseApp.configure()
        return true}
}
