//  ContentView.swift
//  Rayo
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
// sets isLogged in to false so you 
    @AppStorage("isLoggedIn") var isLoggedIn = false

    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var errorMessage: String? = nil
//connects to loginview
    var body: some View {
        loginView
    }

    // our loginview functionailty
    var loginView: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()

            Circle()
                .scale(1.7)
                .foregroundColor(.white.opacity(0.15))

            Circle()
                .scale(1.35)
                .foregroundColor(.white)

            VStack(spacing: 20) {

                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 50)

                TextField("Email", text: $username)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .frame(width: 321, height: 53)
                    .background(Color.black.opacity(0.07))
                    .cornerRadius(9)

                SecureField("Password", text: $password)
                    .padding()
                    .frame(width: 321, height: 53)
                    .background(Color.black.opacity(0.07))
                    .cornerRadius(9)

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
                //creates our button login and the color and size
                Button("Login to Rayo") {
                    authenticateUser()
                }
                .foregroundColor(.white)
                .frame(width: 321, height: 53)
                .background(Color.blue)
                .cornerRadius(7)
                //creates our button sign up and the color and size
                Button("Sign Up") {
                    signUpUser()
                }
                .foregroundColor(.white)
                .frame(width: 321, height: 53)
                .background(Color.green)
                .cornerRadius(7)
            }
        }
    }

    // login function authenticator
    func authenticateUser() {
        Auth.auth().signIn(withEmail: username, password: password) { result, error in
// if our login fails prints login failed
            if let error = error {
                print("Login failed: \(error.localizedDescription)")
                wrongUsername = 2
                wrongPassword = 2
                errorMessage = error.localizedDescription
                return
            }
//if error doesnt occur then prints logging in was successful
            print("Login successful!")
            wrongUsername = 0
            wrongPassword = 0
            errorMessage = nil

            // THIS make NavView switch to MainView by setting it to to true
            isLoggedIn = true
        }
    }

    // helps user sign up function
    func signUpUser() {
        Auth.auth().createUser(withEmail: username, password: password) { result, error in

            if let error = error {
                errorMessage = error.localizedDescription
                return
            }

            print("User created!")
            errorMessage = nil

            // helps you login once you finish signing up
            isLoggedIn = true
        }
    }
}
