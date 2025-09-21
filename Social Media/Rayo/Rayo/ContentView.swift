//
//  ContentView.swift
//  Rayo
//
//  Created by Feliciano Medina on 9/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
            Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
            Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
            
                VStack {
                    //Text("Rayo")
                     //   .font(.largeTitle)
                        
                     //   .bold()
                     //   .padding(.bottom, 120) //space for Rayo and Login
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 50)
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 320, height:50)
                        .background(Color.black.opacity(0.07))
                        .cornerRadius(9)
                        .border(.red, width: CGFloat(wrongUsername))
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 320, height:50)
                        .background(Color.black.opacity(0.07))
                        .cornerRadius(9)
                        .border(.red, width: CGFloat(wrongPassword))
                    Button("Login to Rayo") {
                        //Authenticate user
                        authenticateUser(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 320, height: 50)
                    .background(Color.blue)
                    .cornerRadius(7)
                    NavigationLink("", value: username)
                        .opacity(0)
                   // NavigationLink(destination: Text("You are logging in @\(username)"), isActive: $showingLoginScreen) {
                   //     EmptyView()
                    }
                }
            
            .navigationDestination(for: String.self) { user in
                Text("You are logging in @\(user)")
            }
            
        }
    }
    func authenticateUser(username: String, password: String) {
        if username.lowercased() == "mario1234"{
            wrongUsername = 0
            if password.lowercased() == "abc123"{
                wrongPassword = 0
                showingLoginScreen = true
            }else {
                wrongPassword = 2
            }
        }else {
            wrongUsername = 2
        }
    }
}

#Preview {
    ContentView()
}
