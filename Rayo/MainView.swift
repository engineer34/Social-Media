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
            NavigationView {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(posts) { post in
                            PostCard(post: post)
                        }
                    }
                    .padding(.top)
                }
                .navigationTitle("Rayo")
                .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button("Logout") {
                                        try? Auth.auth().signOut()
                                        isLoggedIn = false
                                    }
                                }
                            }
                .onAppear(perform: loadPosts)
            }
        }
    }

extension MainView {
    private func loadPosts() {
        db.collection("posts")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { snap, error in
                
                if let error = error {
                    print("Firestore error: \(error.localizedDescription)")
                    return
                }
                guard let docs = snap?.documents else { return }
                
                self.posts = docs.compactMap { doc in
                    try? doc.data(as: PostModel.self)
                }
            }
    }
}
