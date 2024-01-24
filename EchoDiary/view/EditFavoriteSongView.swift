//
//  EditFavoriteSongView.swift
//  EchoDiary
//
//  Created by JVH on 24/01/2024.
//

import SwiftUI

struct EditFavoriteSongView: View {
    @ObservedObject var viewModel: EditFavoriteSongViewModel
    @State private var title = ""
    @State private var artist = ""
    @State private var dateAdded = Date()

    var body: some View {
        Form {
            Section(header: Text("Details")) {
                TextField("Title", text: $title)
                TextField("Artist", text: $artist)
                DatePicker("Date Added", selection: $dateAdded, displayedComponents: .date)
            }

            Section {
                Button("Save Changes") {
                    viewModel.updateDetails(title: title, artist: artist, dateAdded: dateAdded)
                    viewModel.saveChanges()
                }
            }
        }
        .onAppear {
            // Set initial values when the view appears
            title = viewModel.editedSong.trackName
            artist = viewModel.editedSong.artistName
            dateAdded = viewModel.editedSong.dateAdded ?? Date()
        }
        .navigationTitle("Edit Song")
    }
}
