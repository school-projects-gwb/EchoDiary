import Foundation
import Combine

let debugSearchTerm = "john mayer"

class SongListViewModel: ObservableObject {
    @Published var searchTerms: String = ""
    @Published var songs: [Song] = [Song]()
    let maxSearchAmount = 10;
    
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
        if searchTerms.isEmpty {
            DispatchQueue.main.async {
                self.songs.removeAll()
            }
            
            return
        }

        if searchTerms.lowercased() == debugSearchTerm {
            guard let fileUrl = Bundle.main.url(forResource: "debugData", withExtension: "json") else {
                print("Debug JSON file not found.")
                return
            }

            do {
                let data = try Data(contentsOf: fileUrl)
                let decodedResponse = try JSONDecoder().decode(SongResult.self, from: data)

                DispatchQueue.main.async {
                    self.songs = decodedResponse.results
                }
            } catch {
                print("Error reading debug JSON file: \(error)")
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
