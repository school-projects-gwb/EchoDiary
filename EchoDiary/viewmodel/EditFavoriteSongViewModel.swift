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

    func updateSong(title: String, artist: String, dateAdded: Date, note: String) {
        var updatedSong = editedSong
        updatedSong.trackName = title
        updatedSong.artistName = artist
        updatedSong.dateAdded = dateAdded
        updatedSong.note = note

        if let index = FavoriteSongManager.shared.favoriteSongs.firstIndex(where: { $0.id == editedSong.id }) {
            FavoriteSongManager.shared.favoriteSongs[index] = updatedSong
        }

        editedSong = updatedSong
    }

    func saveChanges() {
        FavoriteSongManager.shared.saveFavoriteSongs(FavoriteSongManager.shared.favoriteSongs)
    }

    func deleteSong() {
        FavoriteSongManager.shared.deleteSong(id: editedSong.id)
    }
}
