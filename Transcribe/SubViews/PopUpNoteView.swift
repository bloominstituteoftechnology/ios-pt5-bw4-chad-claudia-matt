//
//  PopUpNoteView.swift
//  Transcribe
//
//  Created by Matthew Martindale on 8/25/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import SwiftUI

struct PopUpNoteView: View {
    
    var note: Note
    
    var body: some View {
        
        VStack {
            Text(note.title)
                .padding(10)
                .font(Font.title)
            Divider()
            ScrollView(.vertical, showsIndicators: false) {
                Text(note.bodyText)
            }.padding(.horizontal, 20)
                .padding(.bottom, 20)
        }.frame(width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.height * 0.5)
        .background(Color("backgroundColor"))
        .cornerRadius(20)
    }
}

struct PopUpNoteView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpNoteView(note: Note(title: "Popup", bodyText: "body text", audioFilename: "", color: .red, category: "popUp"))
    }
}
