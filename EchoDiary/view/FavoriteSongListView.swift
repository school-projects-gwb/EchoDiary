//
//  FavoriteSongListView.swift
//  EchoDiary
//
//  Created by JVH on 24/01/2024.
//

import SwiftUI

struct FavoriteSongListView: View {
    @StateObject private var viewModel = FavoriteSongListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.favoriteSongs) { favoriteSong in
                NavigationLink(destination: EditFavoriteSongView(viewModel: EditFavoriteSongViewModel(song: favoriteSong))) {
                    HStack {
                        AsyncImage(url: URL(string: favoriteSong.artworkUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .cornerRadius(5)
                        } placeholder: {
                            Color.gray
                                .frame(width: 50, height: 50)
                                .cornerRadius(5)
                        }

                        VStack(alignment: .leading) {
                            Text(favoriteSong.trackName)
                                .font(.headline)
                            Text(favoriteSong.artistName)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("Added on: \(formattedDate(favoriteSong.dateAdded))")
                                .font(.caption)
                                .foregroundColor(.gray)

                            if let note = favoriteSong.note, !note.isEmpty {
                                Text(note)
                                    .font(.callout)
                                    .foregroundColor(.pink)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Favorite Songs")
            .onAppear {
                viewModel.refreshList()
            }
        }

    }

    private func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "N/A" }
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    FavoriteSongListView()
}
