//
//  SongListViewModel.swift
//  EchoDiary
//
//  Created by JVH on 24/01/2024.
//

import Foundation
import Combine

// https://itunes.apple.com/search?term=ufo361&entity=song&limit=5

class SongListViewModel: ObservableObject {
    
    @Published var searchTerms: String = "ufo361"
    @Published var songs: [Song] = [Song]()
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        $searchTerms
            .dropFirst()
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
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(searchTerms)&entity=song&limit=5") else {
            print("Data at URL not found")
            return
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(SongResult.self, from: data)
        
        // Switch to the main thread before updating @Published property
        DispatchQueue.main.async {
            self.songs = decodedResponse.results
        }
    }
}
