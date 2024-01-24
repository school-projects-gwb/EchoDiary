//
//  EditFavoriteSongViewModel.swift
//  EchoDiary
//
//  Created by JVH on 24/01/2024.
//

import Foundation

class EditFavoriteSongViewModel: ObservableObject {
    @Published var editedSong: FavoriteSong

    init(song: FavoriteSong) {
        self.editedSong = song
    }

    func updateDetails(title: String, artist: String, dateAdded: Date) {
        editedSong.trackName = title
        editedSong.artistName = artist
        editedSong.dateAdded = dateAdded
    }

    func saveChanges() {
        var favoriteSongs = FavoriteSongManager.shared.favoriteSongs

        if let index = favoriteSongs.firstIndex(where: { $0.id == editedSong.id }) {
            favoriteSongs[index] = editedSong
            FavoriteSongManager.shared.saveFavoriteSongs(favoriteSongs)
        }
    }
}
