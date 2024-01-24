//
//  SongListView.swift
//  EchoDiary
//
//  Created by JVH on 24/01/2024.
//

import SwiftUI

struct SongListView: View {
    
    @StateObject var viewModel = SongListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.songs) { song in
                HStack {
                    // Song Art Image
                    AsyncImage(url: URL(string: song.artworkUrl30)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 30, height: 30)
                            .cornerRadius(5)
                    } placeholder: {
                        // Placeholder image or activity indicator can be added here
                        Color.gray
                            .frame(width: 30, height: 30)
                            .cornerRadius(5)
                    }
                    
                    // Song Title and Artist Name
                    VStack(alignment: .leading) {
                        Text(song.trackName)
                            .font(.headline)
                        Text(song.artistName)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 8)
                    
                    // Favorite Button
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
        }
    }
    
    private func addSongToFavorites(_ song: Song) {
        let favoriteSong = FavoriteSong(
            trackName: song.trackName,
            artistName: song.artistName,
            artworkUrl: song.artworkUrl30
        )

        // Get existing favorite songs, add the new one, and save the updated list
        var favoriteSongs = FavoriteSongManager.shared.favoriteSongs
        favoriteSongs.append(favoriteSong)
        FavoriteSongManager.shared.saveFavoriteSongs(favoriteSongs)

        // Optionally, you can update UI or show a confirmation message
        print("Added to favorites: \(favoriteSong.trackName) by \(favoriteSong.artistName)")
    }
}

#Preview {
    SongListView()
}
