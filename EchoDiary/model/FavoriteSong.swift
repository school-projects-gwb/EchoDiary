//
//  FavoriteSong.swift
//  EchoDiary
//
//  Created by JVH on 24/01/2024.
//

import Foundation

struct FavoriteSong : Codable, Identifiable {
    let id: UUID
    var trackName: String
    var artistName: String
    var artworkUrl: String
    var dateAdded: Date?
    var note: String?
    
    init(id: UUID = UUID(), trackName: String, artistName: String, artworkUrl: String, dateAdded: Date? = Date()) {
        self.id = id
        self.trackName = trackName
        self.artistName = artistName
        self.artworkUrl = artworkUrl
        self.dateAdded = dateAdded
        self.note = ""
    }
    
    static var example: FavoriteSong {
        return FavoriteSong(
            trackName: "Example Song",
            artistName: "Example Artist",
            artworkUrl: "https://picsum.photos/200/300.jpg",
            dateAdded: Date()
        )
    }
}

class FavoriteSongManager: ObservableObject {
    static let shared = FavoriteSongManager()

    private let userDefaults = UserDefaults.standard
    private let key = "favoriteSongs"

    @Published var favoriteSongs: [FavoriteSong] {
        didSet {
            saveFavoriteSongs(favoriteSongs)
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

    func addSong(favoriteSong: FavoriteSong) {
        favoriteSongs.append(favoriteSong)
        
        if let encodedData = try? JSONEncoder().encode(favoriteSongs) {
            userDefaults.set(encodedData, forKey: key)
        }
    }
    
    func saveFavoriteSongs(_ songs: [FavoriteSong]) {        
        if let encodedData = try? JSONEncoder().encode(songs) {
            userDefaults.set(encodedData, forKey: key)
        }
    }
    
    func deleteSong(id: UUID) {
        favoriteSongs.removeAll { $0.id == id }
        saveFavoriteSongs(favoriteSongs)
    }
}
