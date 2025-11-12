//
//  Post.swift
//  Rayo
//
//  Created by Feliciano Medina on 10/21/25.
//
// Citations https://github.com/Cebraiil/SocialMediaAppUI/tree/main/SocialMediaTutorial
import SwiftUI

struct PostListView: View {
    @ObservedObject var postData = ReadJsonData() // Observed object for reading JSON data
    
    var body: some View {
        VStack {
            ForEach(postData.posts) { post in // Iterate over each post in the data
                PostCard(post: post)
                .padding(.top)
            }
            
        }
        
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
    }
}
