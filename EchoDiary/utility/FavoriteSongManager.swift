import Foundation

class FavoriteSongManager: ObservableObject {
    static let shared = FavoriteSongManager()

    private let userDefaults = UserDefaults.standard
    private let key = "favoriteSongs"

    @Published var favoriteSongs: [FavoriteSong] {
        didSet {
            saveFavoriteSongsToUserDefaults(favoriteSongs)
        }
    }

    private init() {
        if let data = userDefaults.data(forKey: key),
           let decodedSongs = try? JSONDecoder().decode([FavoriteSong].self, from: data) {
            favoriteSongs = decodedSongs
        } else {
            favoriteSongs = []
        }
    }

    func addFavoriteSongToUserDefaults(favoriteSong: FavoriteSong) {
        favoriteSongs.append(favoriteSong)
        
        if let encodedData = try? JSONEncoder().encode(favoriteSongs) {
            userDefaults.set(encodedData, forKey: key)
        }
    }
    
    func saveFavoriteSongsToUserDefaults(_ songs: [FavoriteSong]) {
        if let encodedData = try? JSONEncoder().encode(songs) {
            userDefaults.set(encodedData, forKey: key)
        }
    }
    
    func deleteFavoriteSong(id: UUID) {
        favoriteSongs.removeAll { $0.id == id }
        saveFavoriteSongsToUserDefaults(favoriteSongs)
    }
}
