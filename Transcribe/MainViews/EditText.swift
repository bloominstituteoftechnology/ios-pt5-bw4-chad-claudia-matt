//
//  EditText.swift
//  Transcribe
//
//  Created by Claudia Maciel on 8/20/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import SwiftUI

struct EditText: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var noteController: NoteController
    
    @State private var textFieldContents = ""
    
   var note: Note
    var index: Int {return noteController.previewNotes.firstIndex(where: {$0.id == note.id})!}
        
    var body: some View {
        VStack {
            HStack {
                Text("Message").bold()
                Divider()
                TextField("message", text: $textFieldContents, onEditingChanged: { _ in
                    self.noteController.updateMessage(for: self.note, to: self.textFieldContents)
                })
            }.onAppear(perform: loadItemText)
            Spacer()
            Button("Dismiss") {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    func loadItemText() {
        textFieldContents = note.bodyText
    }
}

struct EditText_Previews: PreviewProvider {
    static var previews: some View {
        EditText(note: NoteController().previewNotes[0])
    }
}
