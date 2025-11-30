//
//  PostCard.swift
//  Rayo
//
//  Created by Feliciano Medina on 10/21/25.
// Citations https://github.com/Cebraiil/SocialMediaAppUI/tree/main/SocialMediaTutorial

import SwiftUI

struct PostCard: View {
    let post: PostModel

    var body: some View {
            VStack(alignment: .leading, spacing: 12) {

                // USER HEADER
                HStack(spacing: 12) {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 45, height: 45)
                        .overlay(
                            Text(post.username.prefix(1).uppercased())
                                .font(.headline)
                                .foregroundColor(.white)
                        )

                    VStack(alignment: .leading, spacing: 2) {
                        Text(post.username)
                            .font(.headline)

                        Text(post.email)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    Text(post.timestamp.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                // POST IMAGE
                if !post.imageURL.isEmpty {
                    AsyncImage(url: URL(string: post.imageURL)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxHeight: 300)
                            .clipped()
                            .cornerRadius(12)
                    } placeholder: {
                        ProgressView()
                    }
                }

                // CAPTION
                Text(post.text)
                    .font(.body)
                    .padding(.top, 4)
            }
            .padding()
        }
    }

