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
        // Simulate refreshing the list by re-loading data from UserDefaults
        loadFavoriteSongs()
    }

    private func loadFavoriteSongs() {
        if let data = UserDefaults.standard.data(forKey: "favoriteSongs"),
           let decodedSongs = try? JSONDecoder().decode([FavoriteSong].self, from: data) {
            favoriteSongs = decodedSongs
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
}
