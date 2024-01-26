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
                    VStack(alignment: .leading, spacing: 8) {
                        Text("\(formattedDate(favoriteSong.dateAdded))")
                            .font(.headline)
                            .foregroundColor(.primary) // Use dynamic text color

                        HStack(spacing: 8) {
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
                                    .font(.subheadline)
                                    .foregroundColor(.primary) // Use dynamic text color
                                Text(favoriteSong.artistName)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary) // Use dynamic text color
                            }
                        }

                        if let note = favoriteSong.note, !note.isEmpty {
                            Text(trimAndAddDots(note, maxLength: 100))
                                .font(.caption)
                                .italic()
                                .foregroundColor(.primary) // Use dynamic text color
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemBackground)) // Use dynamic background color
                    .cornerRadius(8)
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .background(Color(UIColor.systemBackground)) // Use dynamic background color
            .navigationTitle("EchoDiary")
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
    
    private func trimAndAddDots(_ input: String, maxLength: Int) -> String {
        guard input.count > maxLength else {
            return input
        }

        let trimmedString = input.prefix(maxLength)
        return "\(trimmedString)..."
    }
}

struct FavoriteSongListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteSongListView()
            .preferredColorScheme(.dark) // Preview in dark mode
    }
}


#Preview {
    FavoriteSongListView()
}
