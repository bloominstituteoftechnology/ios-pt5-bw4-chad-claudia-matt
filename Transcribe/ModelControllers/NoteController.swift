//
//  NoteController.swift
//  Transcribe
//
//  Created by Chad Parker on 8/18/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import Foundation

class NoteController: ObservableObject {

    @Published var previewNotes: [Note] = [
        Note(title: "Test 1", bodyText: "Ajfkldsjfldksjfldskjfdkls jkflds jkflds jfklds jfklds", audioFilename: "", color: .red),
        Note(title: "Test 2", bodyText: "Ajfkldsjfldksjfldskjfdkls jkflds jkflds jfklds jfklds", audioFilename: "", color: .orange),
        Note(title: "Test 3", bodyText: "Ajfkldsjfldksjfldskjfdkls jkflds jkflds jfklds jfklds", audioFilename: "", color: .blue)
    ]
    
    func updateMessage(for note: Note, to newMessage: String) {
        if let index = previewNotes.firstIndex(where: { $0.id == note.id }) {
            previewNotes[index].bodyText = newMessage
        }
    }
    func updateTitle(for note: Note, to newTitle: String) {
        if let index = previewNotes.firstIndex(where: { $0.id == note.id }) {
            previewNotes[index].title = newTitle
        }
    }
}
