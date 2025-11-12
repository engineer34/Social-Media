//
//  StoryC.swift
//  Rayo
//
//  Created by Feliciano Medina on 11/3/25.
// citation https://github.com/Cebraiil/SocialMediaAppUI/blob/main/SocialMediaTutorial/Components/StoryCard/StoryCard.swift
import SwiftUI

struct StoryC: View {
    let image: String // Image name or URL
    
    var body: some View {
        VStack {
            Image(image) // Display the image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60) // Set the size of the image
                .clipShape(Circle()) // Clip the image into a circle shape
                .overlay(
                    Circle()
                        .stroke(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing), lineWidth: 2)
                )
                // Add an overlay circle stroke with a gradient color
        }
    }
}
