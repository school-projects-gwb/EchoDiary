import SwiftUI

struct EditFavoriteSongView: View {
    @ObservedObject var viewModel: EditFavoriteSongViewModel
    @State private var title = ""
    @State private var artist = ""
    @State private var dateAdded = Date()
    @State private var note = ""
    @State private var showAlert = false
    @State private var isDelete = false
    @State private var latitude = "0"
    @State private var longitude = "0"

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Form {
            Section(header: Text("Details")) {
                TextField("Title", text: $title)
                TextField("Artist", text: $artist)
                TextEditor(text: $note)
                    .frame(height: 100)
                DatePicker("Entry date", selection: $dateAdded, displayedComponents: .date)
            }
            
            Section(header: Text("Location: Latitude")) {
                TextField("Latitude", text: $latitude)
            }
            
            Section(header: Text("Location: Longitude")) {
                TextField("Longitude", text: $longitude)
            }

            Section {
                Button("Save Changes") {
                    viewModel.updateFavoriteSong(title: title, artist: artist, dateAdded: dateAdded, note: note, latitude: Double(latitude) ?? 1, longitude: Double(longitude) ?? 1)
                    viewModel.saveFavoriteSongChanges()

                    isDelete = false
                    showAlert = true
                }

                Button("Delete Entry") {
                    isDelete = true
                    showAlert = true
                }
                .foregroundColor(.red)
            }
        }
        .onAppear {
            title = viewModel.editedSong.trackName
            artist = viewModel.editedSong.artistName
            dateAdded = viewModel.editedSong.dateAdded ?? Date()
            note = viewModel.editedSong.note ?? "Dear diary.."
            latitude = String(viewModel.editedSong.latitude)
            longitude = String(viewModel.editedSong.longitude)
            
            if (note.isEmpty) {
                note = "Dear diary.."
            }
        }
        .navigationTitle("Edit diary entry")
        .alert(isPresented: $showAlert) {
            if isDelete {
                return Alert(
                    title: Text("Confirmation"),
                    message: Text("Are you sure you want to delete this entry?"),
                    primaryButton: .cancel(),
                    secondaryButton: .destructive(Text("Delete")) {
                        viewModel.deleteFavoriteSong()
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            } else {
                return Alert(title: Text("Success"), message: Text("Entry saved successfully!"), dismissButton: .default(Text("OK")) {
                    presentationMode.wrappedValue.dismiss()
                })
            }
        }
    }
}
