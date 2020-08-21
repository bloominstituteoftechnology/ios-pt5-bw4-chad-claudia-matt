//
//  DetailView.swift
//  Transcribe
//
//  Created by Claudia Maciel on 8/19/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.editMode) var mode
    @EnvironmentObject var transcribeData: TranscribeData
    @State var note: Note
    @State private var editText = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                EditButton()
            }
            ZStack(alignment: .bottomTrailing) {
                Image("soundWave")
                    .resizable()
                    .frame(height: 150)
                    .scaledToFit()
                Button(action: {
                    // Play sound
                }) {
                    Image(systemName: "play.fill")
                        .font(.headline)
                        .padding(4)
                        .background(Color.black)
                        .font(.caption)
                        .foregroundColor(.white)
                        .offset(x: -5, y: -5)
                }
            }
            ZStack(alignment: .bottomTrailing) {
                if self.mode?.wrappedValue == .inactive {
                    Text(note.bodyText)
                        .padding()
                    HStack {
                        Button(action: {
                            // Edit Text
                            self.editText.toggle()
                        }) {
                            Image(systemName: "pencil")
                                .font(.headline)
                                .padding(10)
                                .background(Color.black)
                                .font(.caption)
                                .foregroundColor(.white)
                                .offset(x: -5, y: 5)
                        }
                        Button(action: {
                            // Share
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.headline)
                                .padding(10)
                                .background(Color.black)
                                .font(.caption)
                                .foregroundColor(.white)
                                .offset(x: -5, y: 5)
                        }.sheet(isPresented: $editText) {
                            EditText(note: self.$note)
                        }
                    }
                } else {
                    EditText(note: $note)
                }
                
                
            }
            
            Spacer()
            Button(action: {
                //record audio
            }) {
                Image("record")
                    .resizable()
                    .frame(width: 60, height: 60)
            }
        }
        .navigationBarTitle(Text(note.title), displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(note: NoteController().previewNotes[0]).environmentObject(TranscribeData())
    }
}
