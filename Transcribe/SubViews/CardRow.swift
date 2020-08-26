//
//  CardRow.swift
//  Transcribe
//
//  Created by Matthew Martindale on 8/23/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import SwiftUI

struct CardRow: View {
    
//    @EnvironmentObject var noteController: NoteController
    
    var notesInCategory: [Note]
    var topColor = Int.random(in: 1...3)
    var bottomColor = Int.random(in: 1...3)
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(notesInCategory.indices, id: \.self) { index in
                    GeometryReader { geometry in
                        SingleCardView(note: self.notesInCategory[index])
                            .rotation3DEffect(Angle(degrees:
                                (Double(geometry.frame(in: .global).minX) / -15) + 5),
                                              axis: (x: 0, y: 20.0, z: 0))
                    }
                    .frame(width: 150, height: 250)
                }.padding(.horizontal, 15)
            }.padding()
        }
        .frame(width: UIScreen.main.bounds.width, height: 250)
    }
}

struct CardRow_Previews: PreviewProvider {
    static var previews: some View {
        CardRow(notesInCategory: [Note(title: "First Title", bodyText: "Body text for first note", audioFilename: "audioFile.mp3", color: .blue, category: "Misc."), Note(title: "Second Title", bodyText: "Body text for second note", audioFilename: "audioFile.mp3", color: .red, category: "Misc.")]).previewLayout(.sizeThatFits)
    }
}
