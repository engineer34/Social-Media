import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

struct AddPostView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var description = ""
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    @State private var isUploading = false
    
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Image preview
            Button(action: { showImagePicker = true }) {
                if let img = selectedImage {
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 220)
                        .cornerRadius(10)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 220)
                        .overlay(Text("Tap to upload image").foregroundColor(.secondary))
                }
            }
            .buttonStyle(PlainButtonStyle())

            // Caption / text
            TextField("Write a caption…", text: $description, axis: .vertical)
                .lineLimit(1...5)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            // Post button
            Button(action: savePost) {
                HStack {
                    Spacer()
                    Text(isUploading ? "Posting..." : "Post")
                        .bold()
                    Spacer()
                }
                .padding()
                .background(isUploading ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .disabled(isUploading || description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)

            Spacer()
        }
        .padding()
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $selectedImage)
        }
    }

    // MARK: - Save flow
    private func savePost() {
        let trimmed = description.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            print("Post text is empty")
            return
        }
        guard let user = Auth.auth().currentUser else {
            print("No authenticated user")
            return
        }

        isUploading = true

        // Image selected?
        if let image = selectedImage {
            uploadPostImage(image) { imageURL in
                createPostDocument(user: user, imageURL: imageURL)
            }
        } else {
            createPostDocument(user: user, imageURL: nil)
        }
    }

    // MARK: - Upload image to Firebase Storage
    private func uploadPostImage(_ image: UIImage, completion: @escaping (String?) -> Void) {
        let id = UUID().uuidString
        let ref = storage.reference().child("postImages/\(id).jpg")

        guard let data = image.jpegData(compressionQuality: 0.75) else {
            print("Failed to convert image to JPEG data")
            completion(nil)
            return
        }

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        ref.putData(data, metadata: metadata) { metadata, error in
            if let error = error {
                print("Image upload error: \(error.localizedDescription)")
                completion(nil)
                return
            }

            ref.downloadURL { url, error in
                if let error = error {
                    print("Download URL error: \(error.localizedDescription)")
                    completion(nil)
                    return
                }

                completion(url?.absoluteString)
            }
        }
    }

    // MARK: - Create Firestore document
    private func createPostDocument(user: User, imageURL: String?) {

        let username = user.displayName ?? ""
        let email = user.email ?? ""

        let postData: [String: Any] = [
            "text": description,
            "timestamp": Timestamp(),
            "userId": user.uid,
            "email": email,
            "username": username,
            "imageURL": imageURL ?? ""
        ]

        db.collection("posts").addDocument(data: postData) { error in
            DispatchQueue.main.async {
                self.isUploading = false
                if let error = error {
                    print("Error saving post: \(error.localizedDescription)")
                } else {
                    print("Post successfully created!")
                    self.description = ""
                    self.selectedImage = nil
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

