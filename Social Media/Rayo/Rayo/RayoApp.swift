//
//  RayoApp.swift
//  Rayo
//
//  Created by Feliciano Medina on 9/11/25.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import AuthenticationServices

@main
struct RayoApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
