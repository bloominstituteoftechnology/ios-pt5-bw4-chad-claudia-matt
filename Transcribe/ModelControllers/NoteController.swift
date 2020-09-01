//
//  NoteController.swift
//  Transcribe
//
//  Created by Chad Parker on 8/18/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

// I added a function to our code and to add a new note to our array all we need to do is use self.noteController.add(<note to add>

import Foundation
import SwiftUI
import Combine

final class NoteController: ObservableObject {
    
    @Published var showPopUp = false
    @Published var selectedNote: Note?

    @Published var previewNotes: [Note] = [
        Note(title: "First Note", bodyText: "Trying out transcribe app", audioFilename: "", category: "Misc."),
        Note(title: "First Note", bodyText: "Trying out transcribe app", audioFilename: "", category: "List"),
        Note(title: "First Note", bodyText: "Trying out transcribe app", audioFilename: "", category: "List"),
        Note(title: "First Note", bodyText: "Trying out transcribe app", audioFilename: "", category: "Misc."),
    ]
    
    static let saveKey = "SavedData"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decoded = try? JSONDecoder().decode([Note].self, from: data) {
                self.previewNotes = decoded
                return
            }
        }
        //Uncomment this if we want to not use the premade notes
//        self.previewNotes = []
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(previewNotes) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }
    
    func add(_ note: Note) {
        previewNotes.append(note)
        save()
    }
    
    func delete(_ note: Note) {
        if let deleteNoteAtIndex = previewNotes.firstIndex(where: { $0.id == note.id }) {
            previewNotes.remove(at: deleteNoteAtIndex)
        }
        save()
    }
    
    func updateMessage(for note: Note, to newMessage: String) {
        if let index = previewNotes.firstIndex(where: { $0.id == note.id }) {
            previewNotes[index].bodyText = newMessage
            save()
        }
    }
    func updateTitle(for note: Note, to newTitle: String) {
        if let index = previewNotes.firstIndex(where: { $0.id == note.id }) {
            previewNotes[index].title = newTitle
            save()
        }
    }
    
    func updateCategory(for note: Note, to newCategory: String) {
        if let index = previewNotes.firstIndex(where: { $0.id == note.id }) {
            previewNotes[index].category = newCategory
            save()
        }
    }
    
    func groupByCategory() -> [[Note]] {
        let groupedNotes = Dictionary(grouping: previewNotes) { element -> String in
            return element.category
        }
        
        var categorizedNotes = [[Note]]()
        
        let sortedCategories = groupedNotes.keys.sorted()
        sortedCategories.forEach { key in
            let values = groupedNotes[key]
            categorizedNotes.append(values ?? [])
        }
        
        return categorizedNotes
    }
    
    func add(recording: Recording, to note: Note) {
        guard let noteIndex = previewNotes.firstIndex(where: { $0.id == note.id }) else {
            //fatalError("Existing note not found")
            print("Existing note not found")
            return
        }
        previewNotes[noteIndex].recordings.append(recording)

        var mutableRecording = recording
        Transcriber.transcribeAudioURL(recording.audioFileURL) { text in
            mutableRecording.textTranscript = text
            
            guard let recordingIndex = self.previewNotes[noteIndex].recordings.firstIndex(where: { $0.id == mutableRecording.id }) else {
                fatalError("Existing recording not found")
            }

            self.previewNotes[noteIndex].bodyText += "\n\(text)"
            self.previewNotes[noteIndex].recordings[recordingIndex] = mutableRecording
        }
    }
}

struct NoteController_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
