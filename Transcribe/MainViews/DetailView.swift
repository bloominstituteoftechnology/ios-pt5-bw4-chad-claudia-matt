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
    @EnvironmentObject var noteController: NoteController
    
    var note: Note
    @State private var editText = false
    @State private var isShareSheetShowing = false
    
    var index: Int {return noteController.previewNotes.firstIndex(where: {$0.id == note.id})!}
    
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
                        Button(action: shareButton) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.headline)
                                .padding(10)
                                .background(Color.black)
                                .font(.caption)
                                .foregroundColor(.white)
                                .offset(x: -5, y: 5)
                        }.sheet(isPresented: $editText) {
                            EditText(note: self.note).environmentObject(self.noteController)
                        }
                    }
                } else {
                    EditText(note: note).environmentObject(noteController)
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
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func shareButton() {
        let url = self.getDocumentDirectory().appendingPathComponent("\(self.note.title).txt")
        
        do {
            try self.note.bodyText.write(to: url, atomically: true, encoding: .utf8)
            let input = try String(contentsOf: url)
            print(input)
        } catch {
            print(" Unable to write to file \(error.localizedDescription)")
        }
        
        isShareSheetShowing.toggle()
        
        let av = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(note: NoteController().previewNotes[0]).environmentObject(NoteController())
    }
}
