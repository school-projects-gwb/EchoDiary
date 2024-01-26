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
