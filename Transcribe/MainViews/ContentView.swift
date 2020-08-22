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
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Text("Title")
                    HStack { Spacer() }
                    ForEach(noteController.previewNotes) { note in
                        NavigationLink(destination: DetailView(note: note).environmentObject(self.noteController)) {
                            Text(note.title)
                        }
                    }
                }
                .border(Color.black)
            }.navigationBarTitle("Transcribe")
            .listStyle(GroupedListStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(NoteController())
    }
}
