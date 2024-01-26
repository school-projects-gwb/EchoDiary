import SwiftUI

struct SongListView: View {
    @StateObject var viewModel = SongListViewModel()
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            List(viewModel.songs) { song in
                HStack {
                    AsyncImage(url: URL(string: song.artworkUrl30)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 30, height: 30)
                            .cornerRadius(5)
                    } placeholder: {
                        Color.gray
                            .frame(width: 30, height: 30)
                            .cornerRadius(5)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(song.trackName)
                            .font(.headline)
                        Text(song.artistName)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 8)
                    
                    Spacer()
                    Button(action: {
                        addSongToFavorites(song)
                    }) {
                        Image(systemName: "heart")
                            .foregroundColor(.red)
                            .font(.system(size: 20))
                    }
                    .padding(.trailing, 8)
                }
            }
            .listStyle(.plain)
            .searchable(text: $viewModel.searchTerms)
            .navigationTitle("Search songs")
            .alert(isPresented: $showAlert) {
                            Alert(title: Text("Success"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
        }
    }
    
    private func addSongToFavorites(_ song: Song) {
        let favoriteSong = FavoriteSong(
            trackName: song.trackName,
            artistName: song.artistName,
            artworkUrl: song.artworkUrl30
        )

        FavoriteSongManager.shared.addSong(favoriteSong: favoriteSong)
        
        alertMessage = "Added to favorites: \(favoriteSong.trackName) by \(favoriteSong.artistName)"
        showAlert = true
    }
}

#Preview {
    SongListView()
}
