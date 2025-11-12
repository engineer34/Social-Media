//
//  Story.swift
//  Rayo
//
//  Created by Feliciano Medina on 11/3/25.
//
import SwiftUI

struct Story: View {
    @ObservedObject var postData = ReadJsonData()
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            
        
            HStack {
                AddStory()
                ForEach(postData.posts) { post in
                    StoryC(image: post.profile_img)
                }
            }
        }
        .offset(x: 15)
    }
}
