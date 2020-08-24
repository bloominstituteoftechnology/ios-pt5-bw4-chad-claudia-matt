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
    
    var categorizedNotes = CategorizeNotes()
    
    var body: some View {
        
        ZStack {
            Color("backgroundColor").edgesIgnoringSafeArea(.all)
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    Image(systemName: "book.circle").resizable()
                        .foregroundColor(.pink)
                        .frame(height: 200, alignment: .center)
                        .aspectRatio(1, contentMode: .fit)
                        .padding(50)
                    
                    // group each category into its own array of Note objects
                    
                    ForEach(categorizedNotes.testCategorizedNotes, id: \.self) { notes in
                        VStack {
                            Text("\(notes[0].category)")
                                .font(.title)
                            CardRow(notesInCategory: notes)
                        }
                    }
                }
            }
        }
    }

//    var body: some View {
//        NavigationView {
//            ScrollView(.vertical) {
//                VStack(alignment: .leading) {
//                    Text("Title")
//                    HStack { Spacer() }
//                    ForEach(noteController.previewNotes) { note in
//                        NavigationLink(destination: DetailView(note: note).environmentObject(self.noteController)) {
//                            Text(note.title)
//                        }
//                    }
//                }
//                .border(Color.black)
//            }.navigationBarTitle("Transcribe")
//            .listStyle(GroupedListStyle())
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView()
//            .environmentObject(NoteController())
        Group {
            ContentView().environmentObject(NoteController())
            ContentView().environmentObject(NoteController())
                .environment(\.colorScheme, .dark)
        }
    }
}
