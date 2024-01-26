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
