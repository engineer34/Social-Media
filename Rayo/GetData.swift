//
//  GetData.swift
//  Rayo
//
//  Created by Feliciano Medina on 10/21/25.
//
import Foundation

// Struct for representing a post
struct Post: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case image
        case like_count = "like_count"
        case comment_count = "comment_count"
        case view_count = "view_count"
        case description
        case profile_img = "profile_img"
        case profile_name = "profile_name"
        case profile_id = "profile_id"
    }
    
    var id = UUID() // Unique identifier for the post
    var image: String // Image name or URL
    var like_count: Int // Number of likes
    var comment_count: Int // Number of comments
    var view_count: Int // Number of views
    var description: String // Description of the post
    var profile_img: String // Profile image name or URL
    var profile_name: String // Profile name
    var profile_id: String // Profile ID
}

// reads JSON data
class ReadJsonData: ObservableObject {
    @Published var posts = [Post]() // Array of posts
    
    init() {
        loadData() // Load the JSON data upon initialization
    }
    
    func loadData() {
        guard let url = Bundle.main.url(forResource: "posts", withExtension: "json") else {
            print("json file not found")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decodedPosts = try JSONDecoder().decode([Post].self, from: data)
            self.posts = decodedPosts
            print(" Loaded \(decodedPosts.count) posts successfully")
        } catch {
            print(" didn't load \(error)")
        }
    }
}
