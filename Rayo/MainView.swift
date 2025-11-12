//
//  MainView.swift
//  Rayo
//
//  Created by Feliciano Medina on 9/17/25.
//
import FirebaseFirestore
import SwiftUI
import FirebaseAuth
struct MainView: View {
    // this connects to the same key as in ContentView, so when you log out,
       // it automatically switches back to the login screen
    @AppStorage("isLoggedIn") var isLoggedIn = false
    //firsetore connection and posts list
    @State private var posts: [PostModel] = []
    private let db = Firestore.firestore()
    var body: some View {
        NavigationStack {
                    VStack {
                        // Top bar with app title and logout
                        HStack {
                            Text("Rayo")
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                            Button(action: logoutUser) {
                                Text("Logout")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color.red)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)

                        // Scrollable stories and posts
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 20) {
                                Story()
                                PostListView()
                            }
                            .padding(.bottom, 80)
                        }
                    }
                    .navigationBarHidden(true)
                    .onAppear(perform: fetchPosts)
                }
            }
    func fetchPosts() {
          db.collection("posts")
              .order(by: "timestamp", descending: true)
              .getDocuments { snapshot, error in
                  if let error = error {
                      print("Error fetching posts: \(error.localizedDescription)")
                      return
                  }
                  posts = snapshot?.documents.compactMap { doc in
                      let data = doc.data()
                      let text = data["text"] as? String ?? ""
                      let timestamp = (data["timestamp"] as? Timestamp)?.dateValue() ?? Date()
                      return PostModel(text: text, timestamp: timestamp)
                  } ?? []
              }
      }
            // Logs out the user and returns to login screen
            private func logoutUser() {
                do {
                    try Auth.auth().signOut()
                    isLoggedIn = false  //  This triggers ContentView to show Login page
                } catch {
                    print("Error signing out: \(error.localizedDescription)")
                }
            }
        }


        
        /*NavigationView {
            ZStack(alignment: .bottomTrailing) {
                //  ScrollView(.vertical) {
                ScrollView {
                // welcome thwem to rayo
                VStack(spacing: 12) {
                    Story()
                        .padding(.top, 8)
                    //move my stories more up
                    ForEach(0..<5) { _ in
                    PostListView()
                    }
                    
                }
                .padding(.horizontal)
            }
                // create logout button
                
            Button(action: logoutUser) {
                                Text("Logout")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(Color.red)
                                    .cornerRadius(12)
                                    .shadow(radius: 3)
                            }
                            .padding(.trailing, 20)
                            .padding(.bottom, 20)
                        }
                        .navigationTitle("Rayo")
                        .navigationBarTitleDisplayMode(.inline)
                    }
                }
private func logoutUser() {
      do {
          try Auth.auth().signOut()
          isLoggedIn = false
      } catch {
          print("Error signing out: \(error.localizedDescription)")
      }
  }
}
  /*  private var statusView: some View {
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
}*/
struct MainView: View {
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
