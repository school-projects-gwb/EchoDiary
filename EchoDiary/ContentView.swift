import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var viewModel: FavoriteSongListViewModel
    @ObservedObject var currentLocationManager = CurrentLocationManager.shared
    
    var body: some View {
        if (!currentLocationManager.locationAccessDecisionMade) {
            GrantLocationAccessView()
        } else {
            TabView {
                FavoriteSongListView(viewModel: viewModel)
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
}

#Preview {
    ContentView()
        .environmentObject(FavoriteSongListViewModel())
}
