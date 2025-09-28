//
//  ContentView.swift
//  Rayo
//
//  Created by Feliciano Medina on 9/11/25.
//
import FirebaseAuth
import SwiftUI
struct ContentView: View {
    @State private var username = ""// string for our user
    @State private var password = ""// password
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var navigateToHome: String? = nil   // drives Navigation
    @State private var errorMessage: String? = nil     // show errors if sign up/login fails

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

                VStack(spacing: 20) {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 50)

                    TextField("Email", text: $username)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
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

                    // Show error messages
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }

                    // Login Button
                    Button("Login to Rayo") {
                        authenticateUser(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 320, height: 50)
                    .background(Color.blue)
                    .cornerRadius(7)

                    // Sign Up Button
                    Button("Sign Up") {
                        signUpUser(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 320, height: 50)
                    .background(Color.green)
                    .cornerRadius(7)

                    // Hidden NavigationLink
                    NavigationLink("", value: navigateToHome)
                        .opacity(0)
                }
            }
            .navigationDestination(for: String.self) { user in
                Text("You are logged in as \(user)")
                    .font(.title)
                    .padding()
            }
        }
    }

    // Firebase Login
    // function for authentication
    func authenticateUser(username: String, password: String) {
        Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
            if let error = error {
                // shows login did not go through
                print("Login failed: \(error.localizedDescription)")
                wrongUsername = 2
                wrongPassword = 2
                errorMessage = error.localizedDescription
                navigateToHome = nil
            } else {
                // prints out login was successful
                print("Login successful for \(authResult?.user.email ?? "")")
                wrongUsername = 0
                wrongPassword = 0
                errorMessage = nil
                navigateToHome = authResult?.user.email
            }
        }
    }

    // Firebase Sign up
    func signUpUser(username: String, password: String) {
        Auth.auth().createUser(withEmail: username, password: password) { authResult, error in
            if let error = error {
            print("Sign up failed: \(error.localizedDescription)")
            errorMessage = error.localizedDescription
                return
            }
            print("User created: \(authResult?.user.email ?? "")")
            errorMessage = nil
            navigateToHome = authResult?.user.email
        }
    }
}
//prev
#Preview {
    ContentView()
}
/*import SwiftUI
import FirebaseAuth
struct ContentView: View {
    @State private var username = ""//user string
    @State private var password = ""//password string
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var errorMessage: String? = nil
    @State private var navToHome: String? = nil//drives navigation
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
                    TextField("Email", text: $username)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
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
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                                        }
                    Button("Login to Rayo") {
                        //Authenticate user
                        authenticateUser(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 320, height: 50)
                    .background(Color.blue)
                    .cornerRadius(7)
                    Button("Sign Up") {
                    signUpUser(username: username, password: password)
                                        }
                    .foregroundColor(.white)
                    .frame(width: 320, height: 50)
                    .background(Color.green)
                    .cornerRadius(7)
                    
                    // Hidden NavigationLink
                    NavigationLink("", value: navToHome)
                        .opacity(0)
                }
            }
            .navigationDestination(for: String.self) { user in
                Text("You are logged in as \(user)")
                    .font(.title)
                    .padding()
            }
        }
    }ion(for: String.self) { user in
                Text("You are logging in @\(user)")
            }
            
        }
    }
    func authenticateUser(username: String, password: String) {
        Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
                   if let error = error {
                       print("Login failed: \(error.localizedDescription)")
                       wrongUsername = 2
                       wrongPassword = 2
                       navToHome = nil
                   } else {
                       print("Login successful for \(authResult?.user.email ?? "")")
                       wrongUsername = 0
                       wrongPassword = 0
                       navToHome = authResult?.user.email // 👈 this drives Navigation
                   }
               }
           }
       }

#Preview {
    ContentView()
} */
