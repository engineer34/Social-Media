//
//  AuthView.swift
//  Rayo
//
//  Created by Feliciano Medina on 9/17/25.
//

import SwiftUI

struct NavView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "square.stack.fill")
                }
            Text("Search View")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            Text("New Post")
                .tabItem {
                    Image(systemName: "square.and.pencil")
                }
            Pro()
                .tabItem {
                    Image(systemName: "person")
                }
        }
        .accentColor(.brown)
    }
}
struct NavView_Previews: PreviewProvider {
    static var previews: some View {
        NavView()
    }
}

