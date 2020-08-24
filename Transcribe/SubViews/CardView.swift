//
//  CardView.swift
//  Transcribe
//
//  Created by Matthew Martindale on 8/19/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import SwiftUI
//import Combine

struct CardView: View {
    
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
                        .padding(.bottom, 50)
                    
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
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView().environmentObject(NoteController())
            CardView().environmentObject(NoteController())
                .environment(\.colorScheme, .dark)
        }
    }
}
