import Foundation
import Combine

class FavoriteSongListViewModel: ObservableObject {
    @Published var favoriteSongs: [FavoriteSong] = []
    @Published var isMapViewActive = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        loadFavoriteSongsFromUserDefaults()
        setupFavoriteSongObservers()
    }

    func refreshList() {
        loadFavoriteSongsFromUserDefaults()
    }

    private func loadFavoriteSongsFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "favoriteSongs"),
           let decodedSongs = try? JSONDecoder().decode([FavoriteSong].self, from: data) {
            favoriteSongs = decodedSongs.sorted(by: { $0.dateAdded ?? Date() > $1.dateAdded ?? Date() })
        } else {
            favoriteSongs = []
        }
    }

    private func setupFavoriteSongObservers() {
        $favoriteSongs
            .sink { [weak self] songs in
                self?.saveFavoriteSongs(songs)
            }
            .store(in: &cancellables)
    }

    private func saveFavoriteSongs(_ songs: [FavoriteSong]) {
        if let encodedData = try? JSONEncoder().encode(songs) {
            UserDefaults.standard.set(encodedData, forKey: "favoriteSongs")
        }
    }
    
    func deleteFavoriteSongs(at offsets: IndexSet) {
        favoriteSongs.remove(atOffsets: offsets)
        saveFavoriteSongs(favoriteSongs)
    }
}
