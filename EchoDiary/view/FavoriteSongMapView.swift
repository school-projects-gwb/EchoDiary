import SwiftUI
import MapKit

struct FavoriteSongMapView: View {
    @ObservedObject var viewModel: FavoriteSongListViewModel
    
    var body: some View {
        VStack {
            Map() {
                ForEach(viewModel.favoriteSongs) { song in
                    Marker(song.trackName, coordinate: CLLocationCoordinate2D(latitude: song.latitude, longitude: song.longitude))
                        .tint(.pink)
                }
            }
            .tint(.purple)
            .ignoresSafeArea(.all)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.isMapViewActive.toggle()
                }) {
                    Image(systemName: "arrow.backward")
                }
            }
        }
    }
}

#Preview {
    FavoriteSongMapView(viewModel: FavoriteSongListViewModel())
}
