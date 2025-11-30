//
//  AuthView.swift
//  Rayo
//
//  Created by Feliciano Medina on 9/17/25.
//

import SwiftUI

struct NavView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false

    var body: some View {
      if isLoggedIn {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "square.stack.fill")
                }
            Text("Search View")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            AddPostView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                }
            Pro()
                .tabItem {
                    Image(systemName: "person")
                }
        }
        .accentColor(.brown)
    }else{
        ContentView()
    }
  }
}
struct NavView_Previews: PreviewProvider {
    static var previews: some View {
        NavView()
    }
}

