//
//  NoteController.swift
//  Transcribe
//
//  Created by Chad Parker on 8/18/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class NoteController: ObservableObject {

    @Published var previewNotes: [Note] = [
        Note(title: "First Note", bodyText: "This is my first note, this is so cool. SwiftUI is awesome!", audioFilename: "audioFile1.mp3", color: Color("cardColor3"), category: "Misc."),
        Note(title: "Rap Lyrics", bodyText: "Bust some awesome rhymes, do it everytime-z", audioFilename: "audioFile1.mp3", color: Color("cardColor2"), category: "Lyrics"),
        Note(title: "Grocery List", bodyText: "Buy milk, cheese, bread, sour cream, eggs, cake mix, vegetables, fruit", audioFilename: "audioFile1.mp3", color: Color("cardColor1"), category: "Shopping List"),
        Note(title: "Note to future self in the world, you've come a long way buddy.", bodyText: "This is your future self telling you to avoid riding your bike at night, especially when it rains", audioFilename: "audioFile1.mp3", color: Color("cardColor2"), category: "Misc.")
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
