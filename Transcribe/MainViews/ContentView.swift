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
                        HStack {
                            ZStack {
                                HStack {
                                    Spacer()
                                    Image(systemName: "book.circle")
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fit)
                                            .frame(width: 200, height: 200, alignment: .trailing)
                                        .foregroundColor(.pink)
                                    Spacer()
                                }
                                
                                Image("transcribe").resizable()
                                    .frame(height: 250, alignment: .center)
                                    .aspectRatio(1, contentMode: .fit)
                                    .shadow(color: Color("cardColor2").opacity(0.5), radius: 10, x: 0, y: 0)
                            }
                        }
                        
                        // Groups Notes in array to grouped 2-dimensional array by category
                        ForEach(noteController.groupByCategory(), id: \.self) { notes in
                            VStack {
                                Text("\(notes[0].category)")
                                    .font(.title)
                                CardRow(notesInCategory: notes)
                                Divider()
                            }
                        }
                    }
                    .padding(.top, -70)
                }
                // show popup
                ZStack {
                    if self.noteController.showPopUp {
                        GeometryReader { _ in
                                PopUpNoteView(note: self.noteController.selectedNote!)
                        }.background(Color.black.opacity(0.5).edgesIgnoringSafeArea(.all))
                    }
                }
                
                VStack {
                    HStack {
                        Spacer()
                        AddNoteButtonView().padding()
                    }
                    Spacer()
                }
                
            }.onTapGesture {
                withAnimation {
                    self.noteController.showPopUp = false
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
