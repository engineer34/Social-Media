//
//  Post.swift
//  Rayo
//
//  Created by Feliciano Medina on 10/21/25.
//
// Citations https://github.com/Cebraiil/SocialMediaAppUI/tree/main/SocialMediaTutorial
import SwiftUI

struct PostListView: View {
    var posts: [PostModel]
    @ObservedObject var postData = ReadJsonData() // Observed object for reading JSON data
    
    var body: some View {
        VStack(spacing: 12) {
                    ForEach(posts) { post in
                        PostCard(post: post)
                   }
               }
        
    }
}

/*struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
    }
}*/
