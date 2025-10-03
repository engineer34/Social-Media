//
//  MainView.swift
//  Rayo
//
//  Created by Feliciano Medina on 9/17/25.
//

import SwiftUI
import FirebaseAuth
struct MainView: View {
    //var currentUser: String
    
    var body: some View {
        VStack(spacing: 23){
            // welcome to rayo on homecsreen
        Text("Welcome to Rayo!")
            .font(.largeTitle)
            .bold()
            //shows what youre loggin as
      //  Text("You are logged in as \(currentUser)")
            .foregroundColor(.gray)
            //Button for logout
        Button("Logout"){
            do {
                try Auth.auth().signOut()
            } catch {
                print("Logout failed: \(error.localizedDescription)")
            }
        }
        .foregroundColor(.red)
     }
        .padding()
   }
}
//#Preview {
 //   MainView()
//}
