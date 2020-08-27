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

class NoteController: ObservableObject {
    
    @Published var showPopUp = false
    @Published var selectedNote: Note?

    @Published var previewNotes: [Note] = [
        Note(title: "First Note", bodyText: "This is my first note, this is so cool. SwiftUI is awesome!", audioFilename: "audioFile1.mp3", category: "First Note"),
        Note(title: "Rap Lyrics", bodyText: "Bust some awesome rhymes, do it everytime-z", audioFilename: "audioFile1.mp3", category: "Lyrics"),
        Note(title: "Grocery List", bodyText: "Buy milk, cheese, bread, sour cream, eggs, cake mix, vegetables, fruit", audioFilename: "audioFile1.mp3", category: "Shopping List"),
        Note(title: "Note to future self in the world, you've come a long way buddy.", bodyText: "This is your future self telling you to avoid riding your bike at night, especially when it rains", audioFilename: "audioFile1.mp3", category: "Misc."),
        Note(title: "Rap Lyrics", bodyText: "Bust some awesome rhymes, do it everytime-z", audioFilename: "audioFile1.mp3", category: "Lyrics"),
        Note(title: "Grocery List", bodyText: "Buy milk, cheese, bread, sour cream, eggs, cake mix, vegetables, fruit", audioFilename: "audioFile1.mp3", category: "Shopping List"),
        Note(title: "Birthday Presents", bodyText: "Legos\nNERF guns\nVideo Games\nChocolate Cake\nSoccer Ball\niPad\nParty Streamers", audioFilename: "audioFile1.mp3", category: "Shopping List"),
        Note(title: "Wedding Registration Ideas", bodyText: "kitchenaid mixer, cuisinart blender, leather couch, 70 inch TV, picture frames, wall art.", audioFilename: "audioFile1.mp3", category: "Shopping List"),
        Note(title: "More Wedding Registration Ideas", bodyText: "kitchenaid mixer, cuisinart blender, leather couch, 70 inch TV, picture frames, wall art.", audioFilename: "audioFile1.mp3", category: "Shopping List"),
        Note(title: "Second Note kjsdlkjf l;ksadflkjjkdsf;lkadfjkl a", bodyText: "This is my second note, this is so cool. SwiftUI is awesome!", audioFilename: "audioFile1.mp3", category: "Misc."),
        Note(title: "Whatever note.", bodyText: "This is a longer note to see how the ui responds to longer text. Hopefully it still looks good, if not we'll figure something out", audioFilename: "audioFile1.mp3", category: "Misc.")
    ]
    static let saveKey = "SavedData"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decoded = try? JSONDecoder().decode([Note].self, from: data) {
                self.previewNotes = decoded
                return
            }
        }
        
        self.previewNotes = []
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
}
