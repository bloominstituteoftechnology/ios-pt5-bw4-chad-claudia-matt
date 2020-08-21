//
//  ContentView.swift
//  Transcribe
//
//  Created by Chad Parker on 8/18/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var noteController: NoteController
<<<<<<< HEAD
    
=======
    @EnvironmentObject var transcribeData: TranscribeData

>>>>>>> Text is now editable
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Text("Title")
                    HStack { Spacer() }
                    ForEach(noteController.previewNotes) { note in
<<<<<<< HEAD
                        NavigationLink(destination: DetailView(note: note).environmentObject(self.noteController)) {
=======
                        NavigationLink(destination: DetailView(note: note)) {
>>>>>>> Text is now editable
                            Text(note.title)
                            
                        }
                    }
                }
                .border(Color.black)
            }.navigationBarTitle("Transcribe")
            .listStyle(GroupedListStyle())
<<<<<<< HEAD
=======
            //.environmentObject(self.transcribeData)
>>>>>>> Text is now editable
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(NoteController())
    }
}
