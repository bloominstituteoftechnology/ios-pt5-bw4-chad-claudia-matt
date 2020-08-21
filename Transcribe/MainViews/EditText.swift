//
//  EditText.swift
//  Transcribe
//
//  Created by Claudia Maciel on 8/20/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import SwiftUI

struct EditText: View {
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
>>>>>>> added editText View
=======
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var note: Note
        
    var body: some View {
        VStack {
            HStack {
                Text("Message").bold()
                Divider()
                TextField("message", text: $note.bodyText)
            }
            Spacer()
            Button("Dismiss") {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
>>>>>>> Text is now editable
    }
}

struct EditText_Previews: PreviewProvider {
    static var previews: some View {
<<<<<<< HEAD
<<<<<<< HEAD
        EditText(note: NoteController().previewNotes[0])
=======
        EditText()
>>>>>>> added editText View
=======
        EditText(note: .constant(NoteController().previewNotes[0]))
>>>>>>> Text is now editable
    }
}
