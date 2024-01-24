//
//  FavoriteSongListViewModel.swift
//  EchoDiary
//
//  Created by JVH on 24/01/2024.
//

import Foundation
import Combine

class FavoriteSongListViewModel: ObservableObject {
    @Published var favoriteSongs: [FavoriteSong] = FavoriteSongManager.shared.favoriteSongs

    private var cancellables = Set<AnyCancellable>()

    init() {
        FavoriteSongManager.shared.$favoriteSongs
            .sink { [weak self] songs in
                self?.favoriteSongs = songs
            }
            .store(in: &cancellables)
    }
}
