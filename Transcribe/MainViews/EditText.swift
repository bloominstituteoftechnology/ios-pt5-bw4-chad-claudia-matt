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
    }
}

struct EditText_Previews: PreviewProvider {
    static var previews: some View {
        EditText(note: .constant(NoteController().previewNotes[0]))
    }
}
