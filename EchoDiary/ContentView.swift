//
//  ContentView.swift
//  EchoDiary
//
//  Created by JVH on 24/01/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FavoriteSongListView()
                .tabItem {
                    Label("EchoDiary", systemImage: "house")
                }
            SongListView()
                .tabItem {
                    Label("Find Songs", systemImage: "music.note.list")
                }
        }
    }
}

#Preview {
    ContentView()
}
