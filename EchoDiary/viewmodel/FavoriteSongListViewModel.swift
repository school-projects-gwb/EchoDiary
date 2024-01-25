//
//  FavoriteSongListViewModel.swift
//  EchoDiary
//
//  Created by JVH on 24/01/2024.
//

import Foundation
import Combine

class FavoriteSongListViewModel: ObservableObject {
    @Published var favoriteSongs: [FavoriteSong] = []

    private var cancellables = Set<AnyCancellable>()

    init() {
        loadFavoriteSongs()
        setupObservers()
    }

    func refreshList() {
        loadFavoriteSongs()
    }

    private func loadFavoriteSongs() {
        if let data = UserDefaults.standard.data(forKey: "favoriteSongs"),
           let decodedSongs = try? JSONDecoder().decode([FavoriteSong].self, from: data) {
            favoriteSongs = decodedSongs.sorted(by: { $0.dateAdded ?? Date() > $1.dateAdded ?? Date() })
        } else {
            favoriteSongs = []
        }
    }

    private func setupObservers() {
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
    
    func deleteSongs(at offsets: IndexSet) {
        favoriteSongs.remove(atOffsets: offsets)
        saveFavoriteSongs(favoriteSongs)
    }
}
