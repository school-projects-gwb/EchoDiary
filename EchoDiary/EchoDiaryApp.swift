import SwiftUI

@main
struct EchoDiaryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(FavoriteSongListViewModel())
        }
    }
}
