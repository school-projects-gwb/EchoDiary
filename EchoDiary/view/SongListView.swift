//
//  SongListView.swift
//  EchoDiary
//
//  Created by JVH on 24/01/2024.
//

import SwiftUI

struct SongListView: View {
    
    @StateObject var viewModel = SongListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.songs) { song in
                Text(song.collectionName)
            }
            .listStyle(.plain)
            .searchable(text: $viewModel.searchTerms)
            .navigationTitle("Search songs")
        }
    }
}

#Preview {
    SongListView()
}
