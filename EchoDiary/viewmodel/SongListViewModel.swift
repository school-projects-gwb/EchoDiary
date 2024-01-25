//
//  SongListViewModel.swift
//  EchoDiary
//
//  Created by JVH on 24/01/2024.
//

import Foundation
import Combine

// https://itunes.apple.com/search?term=ufo361&entity=song&limit=5

let debugJSON = """
{
 "resultCount":5,
 "results": [
{"wrapperType":"track", "kind":"song", "artistId":561444659, "collectionId":1395717012, "trackId":1395717035, "artistName":"Rich The Kid", "collectionName":"Plug Walk (Ufo361 Remix) [feat. Ufo361] - Single", "trackName":"Plug Walk (Ufo361 Remix)", "collectionCensoredName":"Plug Walk (Ufo361 Remix) [feat. Ufo361] - Single", "trackCensoredName":"Plug Walk (Ufo361 Remix) [feat. Ufo361]", "artistViewUrl":"https://music.apple.com/us/artist/rich-the-kid/561444659?uo=4", "collectionViewUrl":"https://music.apple.com/us/album/plug-walk-ufo361-remix-feat-ufo361/1395717012?i=1395717035&uo=4", "trackViewUrl":"https://music.apple.com/us/album/plug-walk-ufo361-remix-feat-ufo361/1395717012?i=1395717035&uo=4",
"previewUrl":"https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/34/1e/af/341eaf2e-d30e-6534-7b78-1f52339ce108/mzaf_11701638910837079851.plus.aac.p.m4a", "artworkUrl30":"https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/a4/d9/c5/a4d9c592-d83c-3f69-97fe-a141e5d1c7cb/00602567797272.rgb.jpg/30x30bb.jpg", "artworkUrl60":"https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/a4/d9/c5/a4d9c592-d83c-3f69-97fe-a141e5d1c7cb/00602567797272.rgb.jpg/60x60bb.jpg", "artworkUrl100":"https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/a4/d9/c5/a4d9c592-d83c-3f69-97fe-a141e5d1c7cb/00602567797272.rgb.jpg/100x100bb.jpg", "collectionPrice":1.29, "trackPrice":1.29, "releaseDate":"2018-06-08T12:00:00Z", "collectionExplicitness":"explicit", "trackExplicitness":"explicit", "discCount":1, "discNumber":1, "trackCount":1, "trackNumber":1, "trackTimeMillis":175125, "country":"USA", "currency":"USD", "primaryGenreName":"Hip-Hop/Rap", "contentAdvisoryRating":"Explicit", "isStreamable":true},
{"wrapperType":"track", "kind":"song", "artistId":1685716730, "collectionId":1702644655, "trackId":1702644656, "artistName":"Erick90`S", "collectionName":"Ufo361 - Single", "trackName":"Ufo361", "collectionCensoredName":"Ufo361 - Single", "trackCensoredName":"Ufo361", "artistViewUrl":"https://music.apple.com/us/artist/erick90-s/1685716730?uo=4", "collectionViewUrl":"https://music.apple.com/us/album/ufo361/1702644655?i=1702644656&uo=4", "trackViewUrl":"https://music.apple.com/us/album/ufo361/1702644655?i=1702644656&uo=4",
"previewUrl":"https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview116/v4/e8/a1/99/e8a19959-0ca8-78d9-ec3a-8ba3ab4d51bf/mzaf_7833738818986565508.plus.aac.p.m4a", "artworkUrl30":"https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/91/6f/5b/916f5b47-a990-90d3-ab40-92aa5eab3ebd/135384.jpg/30x30bb.jpg", "artworkUrl60":"https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/91/6f/5b/916f5b47-a990-90d3-ab40-92aa5eab3ebd/135384.jpg/60x60bb.jpg", "artworkUrl100":"https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/91/6f/5b/916f5b47-a990-90d3-ab40-92aa5eab3ebd/135384.jpg/100x100bb.jpg", "collectionPrice":1.29, "trackPrice":1.29, "releaseDate":"2023-08-12T12:00:00Z", "collectionExplicitness":"notExplicit", "trackExplicitness":"notExplicit", "discCount":1, "discNumber":1, "trackCount":1, "trackNumber":1, "trackTimeMillis":195416, "country":"USA", "currency":"USD", "primaryGenreName":"Hip-Hop/Rap", "isStreamable":true},
{"wrapperType":"track", "kind":"song", "artistId":1549550506, "collectionId":1501904601, "trackId":1501905385, "artistName":"Drako", "collectionName":"$limey $eason 2", "trackName":"Ufo361", "collectionCensoredName":"$limey $eason 2", "trackCensoredName":"Ufo361", "artistViewUrl":"https://music.apple.com/us/artist/drako/1549550506?uo=4", "collectionViewUrl":"https://music.apple.com/us/album/ufo361/1501904601?i=1501905385&uo=4", "trackViewUrl":"https://music.apple.com/us/album/ufo361/1501904601?i=1501905385&uo=4",
"previewUrl":"https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview114/v4/9d/7a/2c/9d7a2c12-23af-6486-00d1-bfc63bd6abfb/mzaf_8897579981645809288.plus.aac.p.m4a", "artworkUrl30":"https://is1-ssl.mzstatic.com/image/thumb/Music114/v4/b2/27/9d/b2279de6-e37c-d4b2-6f20-eb3202a6eba5/195081003825.jpg/30x30bb.jpg", "artworkUrl60":"https://is1-ssl.mzstatic.com/image/thumb/Music114/v4/b2/27/9d/b2279de6-e37c-d4b2-6f20-eb3202a6eba5/195081003825.jpg/60x60bb.jpg", "artworkUrl100":"https://is1-ssl.mzstatic.com/image/thumb/Music114/v4/b2/27/9d/b2279de6-e37c-d4b2-6f20-eb3202a6eba5/195081003825.jpg/100x100bb.jpg", "collectionPrice":9.99, "trackPrice":0.99, "releaseDate":"2020-02-08T12:00:00Z", "collectionExplicitness":"explicit", "trackExplicitness":"explicit", "discCount":1, "discNumber":1, "trackCount":21, "trackNumber":16, "trackTimeMillis":181317, "country":"USA", "currency":"USD", "primaryGenreName":"Rap", "contentAdvisoryRating":"Explicit", "isStreamable":true},
{"wrapperType":"track", "kind":"song", "artistId":1511554617, "collectionId":1589128635, "trackId":1589128636, "artistName":"CRANK ALL & Bonson", "collectionName":"4:33 (Ufo361 Remix) - Single", "trackName":"4:33", "collectionCensoredName":"4:33 (Ufo361 Remix) - Single", "trackCensoredName":"4:33 (UFO361 REMIX)", "artistViewUrl":"https://music.apple.com/us/artist/crank-all/1511554617?uo=4", "collectionViewUrl":"https://music.apple.com/us/album/4-33-ufo361-remix/1589128635?i=1589128636&uo=4", "trackViewUrl":"https://music.apple.com/us/album/4-33-ufo361-remix/1589128635?i=1589128636&uo=4",
"previewUrl":"https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/ad/82/37/ad823704-2bb8-f575-5a35-dde8c8fa1f34/mzaf_13498716132116438098.plus.aac.p.m4a", "artworkUrl30":"https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/da/99/b5/da99b54b-7da2-6465-a041-e1f50e15043a/artwork.jpg/30x30bb.jpg", "artworkUrl60":"https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/da/99/b5/da99b54b-7da2-6465-a041-e1f50e15043a/artwork.jpg/60x60bb.jpg", "artworkUrl100":"https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/da/99/b5/da99b54b-7da2-6465-a041-e1f50e15043a/artwork.jpg/100x100bb.jpg", "collectionPrice":0.99, "trackPrice":0.99, "releaseDate":"2021-10-13T12:00:00Z", "collectionExplicitness":"explicit", "trackExplicitness":"explicit", "discCount":1, "discNumber":1, "trackCount":1, "trackNumber":1, "trackTimeMillis":234000, "country":"USA", "currency":"USD", "primaryGenreName":"Hip-Hop/Rap", "contentAdvisoryRating":"Explicit", "isStreamable":true},
{"wrapperType":"track", "kind":"song", "artistId":1454563872, "collectionId":1478261320, "trackId":1478261321, "artistName":"SELMON", "collectionName":"stoned & allein (Remix) [feat. Ufo361] - Single", "trackName":"stoned & allein (feat. Ufo361)", "collectionCensoredName":"stoned & allein (Remix) [feat. Ufo361] - Single", "trackCensoredName":"stoned & allein (feat. Ufo361) [Remix]", "artistViewUrl":"https://music.apple.com/us/artist/selmon/1454563872?uo=4", "collectionViewUrl":"https://music.apple.com/us/album/stoned-allein-feat-ufo361-remix/1478261320?i=1478261321&uo=4", "trackViewUrl":"https://music.apple.com/us/album/stoned-allein-feat-ufo361-remix/1478261320?i=1478261321&uo=4",
"previewUrl":"https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/3a/9e/49/3a9e492e-0403-b03b-a2d0-e791279b59c3/mzaf_12198316872000780030.plus.aac.p.m4a", "artworkUrl30":"https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/92/e8/43/92e843d9-71f7-eea4-e355-df72696fed15/cover_4062851957885.jpg/30x30bb.jpg", "artworkUrl60":"https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/92/e8/43/92e843d9-71f7-eea4-e355-df72696fed15/cover_4062851957885.jpg/60x60bb.jpg", "artworkUrl100":"https://is1-ssl.mzstatic.com/image/thumb/Music115/v4/92/e8/43/92e843d9-71f7-eea4-e355-df72696fed15/cover_4062851957885.jpg/100x100bb.jpg", "collectionPrice":0.99, "trackPrice":0.99, "releaseDate":"2019-09-06T12:00:00Z", "collectionExplicitness":"notExplicit", "trackExplicitness":"notExplicit", "discCount":1, "discNumber":1, "trackCount":1, "trackNumber":1, "trackTimeMillis":179620, "country":"USA", "currency":"USD", "primaryGenreName":"Hip-Hop", "isStreamable":true}]
}
"""

let debugSearchTerm = "ufo361"

class SongListViewModel: ObservableObject {
    
    @Published var searchTerms: String = "ufo361"
    @Published var songs: [Song] = [Song]()
    let maxSearchAmount = 5;
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        $searchTerms
            .dropFirst()
            .debounce(for: .seconds(1.5), scheduler: DispatchQueue.main)
            .sink { [weak self] term in
                guard let self = self else { return }
                Task {
                    do {
                        try await self.fetchSongs(for: term)
                    } catch {
                        print("Error fetching songs: \(error)")
                    }
                }
            }
            .store(in: &subscriptions)
    }
    
    func fetchSongs(for searchTerms: String) async throws {
        if (searchTerms.isEmpty) {
            self.songs.removeAll()
            return
        }
 
        if searchTerms.lowercased() == debugSearchTerm {
            let data = Data(debugJSON.utf8)
            let decodedResponse = try JSONDecoder().decode(SongResult.self, from: data)
            
            DispatchQueue.main.async {
                self.songs = decodedResponse.results
            }
        } else {
            guard let url = createFormattedSearchUrl(for: searchTerms) else {
                print("Data at URL not found")
                return
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decodedResponse = try JSONDecoder().decode(SongResult.self, from: data)
            
            DispatchQueue.main.async {
                self.songs = decodedResponse.results
            }
        }
    }
    
    func createFormattedSearchUrl(for searchTerms: String) -> URL? {
        let baseUrl = "https://itunes.apple.com/search"
        let queryItems = [URLQueryItem(name: "term", value: searchTerms), URLQueryItem(name: "entity", value: "song"), URLQueryItem(name: "limit", value: String(maxSearchAmount))]
        
        var components = URLComponents(string: baseUrl)
        components?.queryItems = queryItems
        
        return components?.url
    }
}
