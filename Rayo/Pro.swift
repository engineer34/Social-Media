//
//  Pro.swift
//  Rayo
//
//  Created by Feliciano Medina on 11/10/25.
// package dependices
import FirebaseAuth
import FirebaseStorage
import SwiftUI
import Firebase
import FirebaseFirestore

import FirebaseAuth

struct PostModel: Identifiable, Codable {
    @DocumentID var id: String? = nil
    var text: String
       var timestamp: Date
       var userId: String
       var email: String
       var username: String
       var imageURL: String
}
      


struct Pro: View {
    
    @State private var postText = ""
        @State private var posts: [PostModel] = []
    @State private var profileImageURL = ""
    @State private var showImageControl = false
    @State private var selectedImage: UIImage?

        @State private var name = ""
        @State private var bio = ""
        
        private let db = Firestore.firestore()
    private let storage = Storage.storage()

        var body: some View {
            NavigationView {
                        ScrollView {
                            VStack(spacing: 20) {

                                // Profile Picture
                                VStack {
                                    if let img = selectedImage {
                                        Image(uiImage: img)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 120, height: 120)
                                            .clipShape(Circle())
                                    } else if !profileImageURL.isEmpty {
                                        AsyncImage(url: URL(string: profileImageURL)) { image in
                                            image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .scaledToFill()
                                        .frame(width: 120, height: 120)
                                        .clipShape(Circle())
                                    } else {
                                        Circle()
                                            .fill(Color.gray.opacity(0.3))
                                            .frame(width: 120, height: 120)
                                            .overlay(
                                                Image(systemName: "camera")
                                                    .font(.largeTitle)
                                                    .foregroundColor(.gray)
                                            )
                                    }

                                    Button("Change Profile Picture") {
                                        showImageControl = true
                                    }
                                }

                                // Name + Bio
                                TextField("Your Name", text: $name)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())

                                TextField("Bio", text: $bio)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())

                                Button(action: saveProfile) {
                                    Text("Save Profile")
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                            }
                            .padding()
                        }
                        .navigationTitle("Profile")
                        .onAppear { loadUserProfile() }
                        .sheet(isPresented: $showImageControl) {
                            ImagePicker(image: $selectedImage)
                                .onDisappear {
                                    if let img = selectedImage {
                                        uploadProfileImage(img)
                                    }
                                }
                        }
                    }
                }

                func loadUserProfile() {
                    guard let uid = Auth.auth().currentUser?.uid else { return }

                    db.collection("profiles").document(uid).getDocument { snap, err in
                        if let data = snap?.data() {
                            name = data["name"] as? String ?? ""
                            bio = data["bio"] as? String ?? ""
                            profileImageURL = data["profileImageURL"] as? String ?? ""
                        }
                    }
                }

                func uploadProfileImage(_ image: UIImage) {
                    guard let uid = Auth.auth().currentUser?.uid else { return }
                    guard let imageData = image.jpegData(compressionQuality: 0.6) else { return }

                    let storageRef = Storage.storage().reference().child("profilePics/\(uid).jpg")
                       let metadata = StorageMetadata()
                       metadata.contentType = "image/jpeg"

                       storageRef.putData(imageData, metadata: metadata) { metadata, error in
                           if let error = error {
                               print("Upload error: \(error.localizedDescription)")
                               return
                           }

                           // Correct downloadURL signature: (URL?, Error?) -> Void
                           storageRef.downloadURL { url, error in
                               if let error = error {
                                   print("Error getting download URL: \(error.localizedDescription)")
                                   return
                               }

                               guard let url = url else {
                                   print("downloadURL returned nil URL")
                                   return
                               }

                               let profileImageURL = url.absoluteString
                               // Save the download URL to Firestore (merge so you don't overwrite other profile fields)
                               self.db.collection("profiles").document(uid).setData(["profileImageURL": profileImageURL], merge: true) { err in
                                   if let err = err {
                                       print("Error saving profile image URL: \(err.localizedDescription)")
                                   } else {
                                       print("Saved profile image URL!")
                                       // Optionally update local state (so image shows immediately)
                                       DispatchQueue.main.async {
                                           self.profileImageURL = profileImageURL
                                       }
                                   }
                               }
                           }
                       }
                   }
                func saveProfile() {
                    guard let uid = Auth.auth().currentUser?.uid else { return }

                    let data: [String: Any] = [
                        "name": name,
                        "bio": bio,
                        "profileImageURL": profileImageURL
                    ]

                    db.collection("profiles").document(uid).setData(data, merge: true)
                }
            }
