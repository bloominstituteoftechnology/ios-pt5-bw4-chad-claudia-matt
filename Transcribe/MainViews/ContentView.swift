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
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: DetailView(note: Note(title: "New Note", bodyText: "", audioFilename: "", category: ""))) {
                            EmptyView()
                        }.buttonStyle(NeumorphicButtonStyle(bgColor: .green))
                    }.padding()
                }
                
            }.onTapGesture {
                withAnimation {
                    self.noteController.showPopUp = false
                }
            }
        }
    }
    
    struct NeumorphicButtonStyle: ButtonStyle {
        var bgColor: Color

        func makeBody(configuration: Self.Configuration) -> some View {
            ZStack {
                Circle()
                .frame(width: 55, height: 55)
                    .foregroundColor(.blue)
                Image(systemName: "plus")
                .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                .frame(width: 20, height: 20)
                .padding(12)
                    .background(LinearGradient(gradient: Gradient(colors: [Color("cardColor1"), Color("cardColor2")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 5, y: 5)
                    .shadow(color: Color.white.opacity(0.1), radius: 10, x: -5, y: -5)
            }.opacity(0.8)
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
