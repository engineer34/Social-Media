//
//  PostCard.swift
//  Rayo
//
//  Created by Feliciano Medina on 10/21/25.
// Citations https://github.com/Cebraiil/SocialMediaAppUI/tree/main/SocialMediaTutorial

import SwiftUI

struct PostCard: View {
    //Properties for the post card
    let post: Post
    
    var body: some View {
        VStack {
            Header(profile_img: post.profile_img,
                   profile_name: post.profile_name,
                   profile_id: post.profile_id
               )

               // Post body (main post image, likes, description, etc.)
               PostBody(
                   image: post.image,
                   like_count: post.like_count,
                   comment_count: post.comment_count,
                   view_count: post.view_count,
                   description: post.description
               )
        }
    }
}
