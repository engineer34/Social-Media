//
//  Header.swift
//  Rayo
//
//  Created by Feliciano Medina on 10/21/25.
//
import SwiftUI

struct Header: View {
    
    let profile_img: String
    let profile_name: String
    let profile_id: String
    
    var body: some View {
        HStack {
            Image(profile_img)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading) {
                Text(profile_name).bold()
                Text(profile_id)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "ellipsis")
        }
    }
}
