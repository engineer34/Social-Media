//
//  Body.swift
//  Rayo
//
//  Created by Feliciano Medina on 10/21/25.
//
import SwiftUI

struct PostBody: View {
    
    let image: String
    let like_count: Int
    let comment_count: Int
    let view_count: Int
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            HStack {
                HStack(spacing: 3) {
                    Image(systemName: "heart")
                    Text("\(like_count)")
                }
                Spacer()
                HStack {
                    Image(systemName: "text.bubble")
                    Text("\(comment_count)")
                }
                Spacer()
                HStack {
                    Image(systemName: "eye")
                    Text("\(view_count)")
                }
                Spacer()
                HStack {
                    Image(systemName: "bookmark")
                }
            }
            .font(.callout)
            
            Text(description)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .font(.callout)
                .foregroundColor(.gray)
                .padding(.horizontal)
        }
        
    }
  

}
