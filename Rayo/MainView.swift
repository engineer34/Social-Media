//
//  MainView.swift
//  Rayo
//
//  Created by Feliciano Medina on 9/17/25.
//

import SwiftUI
import FirebaseAuth
struct MainView: View {
    // this connects to the same key as in ContentView, so when you log out,
       // it automatically switches back to the login screen
    @AppStorage("isLoggedIn") var isLoggedIn = false
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                //  ScrollView(.vertical) {
                
                // welcome thwem to rayo
                VStack(spacing: 12) {
                    statusView
                        .padding(.top, -18) //move my stories more up
                    
                    Text("Welcome to Rayo!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.gray)
                        .padding(.top, 4)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                // create logout button
                
                Button(action: {
                    do {
                        try Auth.auth().signOut()
                        isLoggedIn = false
                    } catch {
                        print("Logout failed: \(error.localizedDescription)")
                    }
                }) { //logout buttom
                    Text("Logout")
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding()
                    
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .shadow(radius: 2)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 20)
            }
            
            .navigationTitle("Rayo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "camera")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "ellipsis")
                }
            }
        }
    }
    
    private var statusView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                Image("image4")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                //adds + story button overlay
                    .overlay(
                        Image(systemName: "plus")
                            .font(.title3)
                            .foregroundColor(.white)
                            .background(Circle().fill(Color.blue))
                            .padding(.leading, 8),
                        alignment: .bottomTrailing
                    )
                // story circles
                ForEach(0..<6, id: \.self) { index in
                    Image("image\(index)")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 85, height: 85)
                        .clipShape(Circle())
                        .overlay(Circle().strokeBorder(Color.orange, lineWidth: 2))
                }
            }
            .padding()
        }
    }
}
/*struct MainView: View {
    //var currentUser: String
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical) {
                statusView
            }
            .navigationTitle("Rayo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "camera")
                    }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "ellipsis")
                }
            }
        }
        
        }
    
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
} */
//#Preview {
 //   MainView()
//}
