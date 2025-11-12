//
//  AddStory.swift
//  Rayo
//
//  Created by Feliciano Medina on 11/3/25.
//
//github citation :https://github.com/Cebraiil/SocialMediaAppUI/blob/main/SocialMediaTutorial/Components/StoryCard/AddStoryCard.swift
import SwiftUI

struct AddStory: View {
    var body: some View {
        VStack {
            Image(systemName: "plus.circle")
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
                .background(Color.blue)
                .clipShape(Circle())
        }
    }
}

struct AddStory_Previews: PreviewProvider {
    static var previews: some View {
        AddStory()
    }
}
