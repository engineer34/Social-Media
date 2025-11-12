//
//  Pro.swift
//  Rayo
//
//  Created by Feliciano Medina on 11/10/25.
//
import SwiftUI
import Firebase
import FirebaseFirestore

import FirebaseAuth

struct PostModel: Identifiable {
    var id = UUID()
    var text: String
    var timestamp: Date
}

struct Pro: View {
    
    @State private var postText = ""
        @State private var posts: [PostModel] = []
        @State private var userEmail = ""
        @State private var userUID = ""
        @State private var name = ""
        @State private var bio = ""
        
        private let db = Firestore.firestore()
        
        var body: some View {
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // this shows profile info including email,UID, and profile
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Profile")
                                .font(.title2).bold()
                            Text("Email: \(userEmail)")
                            Text("User ID: \(userUID)")
                        }
                        .padding(.horizontal)
                        
                        Divider()
                        
                        // Help make a profile
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Create or update profile")
                                .font(.headline)
                            TextField(" your name", text: $name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            TextField("Bio", text: $bio)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            Button(action: saveProfile) {
                                Label("Save Profile", systemImage: "person.crop.circle.badge.plus")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)
                        
                        Divider()
                        
                        // add post
                        VStack(alignment: .leading) {
                            Text("Create a Post")
                                .font(.headline)
                            TextField("What's on your mind?", text: $postText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            Button(action: addPost) {
                                Label("Post", systemImage: "paperplane.fill")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)
                        
                        Divider()
                        
                        //recent posts
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Recent Posts")
                                .font(.headline)
                            ForEach(posts) { post in
                                VStack(alignment: .leading) {
                                    Text(post.text)
                                        .font(.body)
                                    Text(post.timestamp.formatted())
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                        //had help with chatgpt to fix my alignment and padding since mine looked awful
                        .padding(.horizontal)
                    }
                    .padding(.top)
                }// nav title at the very top
                .navigationTitle("Your Profile")
                .onAppear {
                    loadUserProfile()
                    fetchPosts()
                }
            }
        }
        
        // load user profile function
        func loadUserProfile() {
            if let user = Auth.auth().currentUser {
                userEmail = user.email ?? "No email found"
                userUID = user.uid
                fetchProfile()
            } else {
                userEmail = "Not logged in"
                userUID = "N/A"
            }
        }
        
        // get the profile connected from firebase
        func fetchProfile() {
            guard !userUID.isEmpty else { return }
            db.collection("profiles").document(userUID).getDocument { snapshot, error in
                if let data = snapshot?.data() {
                    name = data["name"] as? String ?? ""
                    bio = data["bio"] as? String ?? ""
                }
            }
        }
    // fetch posts from firestore
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
        // save to firebase this also uses the firestore library at the top
        func saveProfile() {
            guard let user = Auth.auth().currentUser else { return }
            db.collection("profiles").document(user.uid).setData([
                "name": name,
                "bio": bio,
                "email": user.email ?? ""
            ]) { error in
                if let error = error {
                    print("Error saving profile: \(error.localizedDescription)")
                } else {
                    print("Profile saved!")
                }
            }
        }
        
        // add post
        func addPost() {
            guard !postText.isEmpty else { return }
            guard let user = Auth.auth().currentUser else { return }

               let newPost: [String: Any] = [
                   "text": postText,
                   "timestamp": Timestamp(date: Date()),
                   "userId": user.uid,
                   "email": user.email ?? ""
               ]

            db.collection("posts").addDocument(data: newPost) { error in
                if let error = error {
                    print("Error saving post: \(error.localizedDescription)")
                } else {
                    print("✅ Post saved successfully!")
                    postText = ""
                    fetchPosts() // refresh after posting
                }
            }
        }
    }

    #Preview {
        Pro()
    }
