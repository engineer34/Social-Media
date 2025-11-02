//
//  PostCard.swift
//  Rayo
//
//  Created by Feliciano Medina on 10/21/25.
// Citations https://github.com/Cebraiil/SocialMediaAppUI/tree/main/SocialMediaTutorial

import SwiftUI

struct PostCard: View {
    //Properties for the post card
    let profile_img: String
    let profile_name: String
    let profile_id: String
    
    let image: String
    let like_count: Int
    let comment_count: Int
    let view_count: Int
    let description: String
    
    var body: some View {
        VStack {
            Header(profile_img: profile_img, profile_name: profile_name, profile_id: profile_id)
            PostBody(image: image, like_count: like_count, comment_count: comment_count, view_count: view_count, description: description)
        }
    }
}
