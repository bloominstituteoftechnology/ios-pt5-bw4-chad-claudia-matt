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
            ZStack {
                
                
                Color("backgroundColor").edgesIgnoringSafeArea(.all)
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        Image(systemName: "book.circle").resizable()
                            .foregroundColor(.pink)
                            .frame(height: 200, alignment: .center)
                            .aspectRatio(1, contentMode: .fit)
                            .padding(50)
                        
                        // Groups Notes in array to grouped 2-dimensional array by category
                        ForEach(noteController.groupByCategory(), id: \.self) { notes in
                            VStack {
                                Text("\(notes[0].category)")
                                    .font(.title)
                                CardRow(notesInCategory: notes)
                            }
                        }
                    }
                }
                // show popup
                ZStack {
                    if self.noteController.showPopUp {
                        GeometryReader { _ in
                            VStack {
                                PopUpNoteView(note: self.noteController.selectedNote!)
                                
                                Button(action: {
                                    withAnimation {
                                        self.noteController.showPopUp.toggle()
                                    }
                                }) {
                                    Image(systemName: "xmark").resizable()
                                        .frame(width: 15, height: 15)
                                        .foregroundColor(.black)
                                        .padding(20)
                                }.background(Color.white)
                                    .clipShape(Circle())
                                    .padding(.top, 25)
                            }
                        }.background(Color.black.opacity(0.5).edgesIgnoringSafeArea(.all))
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
