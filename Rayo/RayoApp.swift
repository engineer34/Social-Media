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
    //works to save bits of data in Userdefaults like loginstate for example
    @AppStorage("isLoggedIn") var isLoggedIn = false
    //Initializes App
    init() {
        //Helps me connect my demo to my firebase project and enables firebase services
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                            NavView()        // show main app AFTER login
                        } else {
                            ContentView()    // show login screen FIRST
                        }
        }
    }
}
