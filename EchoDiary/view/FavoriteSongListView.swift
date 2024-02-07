import SwiftUI

struct FavoriteSongListView: View {
    @State private var isMapViewActive = false
    @ObservedObject private var viewModel: FavoriteSongListViewModel
    
    init(viewModel: FavoriteSongListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.favoriteSongs) { favoriteSong in
                NavigationLink(destination: EditFavoriteSongView(viewModel: EditFavoriteSongViewModel(song: favoriteSong))) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("\(formattedDate(favoriteSong.dateAdded))")
                            .font(.headline)
                            .foregroundColor(.primary)

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
                                    .foregroundColor(.primary)
                                Text(favoriteSong.artistName)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }

                        if let note = favoriteSong.note, !note.isEmpty {
                            Text(trimAndAddDots(note, maxLength: 100))
                                .font(.caption)
                                .italic()
                                .foregroundColor(.primary)
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(8)
                    .listRowSeparator(.hidden)
                    
                }
            }
            .listStyle(.plain)
            .background(Color(UIColor.systemBackground))
            .navigationTitle("EchoDiary")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isMapViewActive.toggle()
                    }) {
                        Image(systemName: isMapViewActive ? "list.bullet" : "map")
                    }
                }
            }
            .onAppear {
                viewModel.refreshList()
            }
        }
        .sheet(isPresented: $isMapViewActive) {
            Button("Back to list") {
                isMapViewActive = false
            }
            
            FavoriteSongMapView(viewModel: viewModel)
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
        FavoriteSongListView(viewModel: FavoriteSongListViewModel())
            .preferredColorScheme(.dark)
    }
}

#Preview {
    FavoriteSongListView(viewModel: FavoriteSongListViewModel())
}
