import Foundation
import MapKit

struct FavoriteSong : Codable, Identifiable {
    let id: UUID
    var trackName: String
    var artistName: String
    var artworkUrl: String
    var dateAdded: Date?
    var note: String?
    var latitude: Double
    var longitude: Double
    
    init(id: UUID = UUID(), trackName: String, artistName: String, artworkUrl: String, dateAdded: Date? = Date(), latitude: Double = 1, longitude: Double = 1) {
        self.id = id
        self.trackName = trackName
        self.artistName = artistName
        self.artworkUrl = artworkUrl
        self.dateAdded = dateAdded
        self.note = ""
        self.latitude = latitude
        self.longitude = longitude
    }
    
    static var example: FavoriteSong {
        return FavoriteSong(
            trackName: "Example Song",
            artistName: "Example Artist",
            artworkUrl: "https://picsum.photos/200/300.jpg",
            dateAdded: Date(),
            latitude: 0,
            longitude: 0
        )
    }
}
