import Foundation

class EditFavoriteSongViewModel: ObservableObject {
    @Published var editedSong: FavoriteSong

    init(song: FavoriteSong) {
        self.editedSong = song
    }

    func updateFavoriteSong(title: String, artist: String, dateAdded: Date, note: String, latitude: Double, longitude: Double) {
        var updatedSong = editedSong
        updatedSong.trackName = title
        updatedSong.artistName = artist
        updatedSong.dateAdded = dateAdded
        updatedSong.note = note
        updatedSong.latitude = latitude
        updatedSong.longitude = longitude

        if let index = FavoriteSongManager.shared.favoriteSongs.firstIndex(where: { $0.id == editedSong.id }) {
            FavoriteSongManager.shared.favoriteSongs[index] = updatedSong
        }

        editedSong = updatedSong
    }

    func saveFavoriteSongChanges() {
        FavoriteSongManager.shared.saveFavoriteSongsToUserDefaults(FavoriteSongManager.shared.favoriteSongs)
    }

    func deleteFavoriteSong() {
        FavoriteSongManager.shared.deleteFavoriteSong(id: editedSong.id)
    }
}
