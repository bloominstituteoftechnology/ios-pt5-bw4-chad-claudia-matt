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
    
    @State private var messageTextFieldContents = ""
    @State private var titleTextFieldContents = ""
    
   var note: Note
    var index: Int {return noteController.previewNotes.firstIndex(where: {$0.id == note.id})!}
        
    var body: some View {
        Form {
            HStack {
                Text("Title").bold()
                Divider()
                TextField("title", text: $titleTextFieldContents, onEditingChanged: { _ in
                    self.noteController.updateTitle(for: self.note, to: self.titleTextFieldContents)
                })
            }.onAppear(perform: loadItemText)
            HStack {
                Text("Message").bold()
                Divider()
                TextField("message", text: $messageTextFieldContents, onEditingChanged: { _ in
                    self.noteController.updateMessage(for: self.note, to: self.messageTextFieldContents)
                })
                //TextView(text: $messageTextFieldContents).frame(numLines: 4)
            }.onAppear(perform: loadItemText)
            Spacer()
            Button("Dismiss") {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    func loadItemText() {
        messageTextFieldContents = note.bodyText
        titleTextFieldContents = note.title
    }
}

struct EditText_Previews: PreviewProvider {
    static var previews: some View {
        EditText(note: NoteController().previewNotes[0])
    }
}
