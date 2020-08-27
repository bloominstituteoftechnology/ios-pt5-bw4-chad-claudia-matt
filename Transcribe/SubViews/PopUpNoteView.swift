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
                .font(Font.system(size: 25))
                .foregroundColor(.white)
            Divider()
            ScrollView(.vertical, showsIndicators: false) {
                Text(note.bodyText)
                    .foregroundColor(Color(#colorLiteral(red: 0.8967368603, green: 0.8914062381, blue: 0.9008343816, alpha: 1)))
            }.padding(.horizontal, 20)
                .padding(.bottom, 20)
        }.frame(width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.height * 0.5)
            .background(RadialGradient(gradient: Gradient(colors: [Color("cardColor2"), Color("cardColor1")]), center: UnitPoint(x: 0, y: 0), startRadius: 0, endRadius: UIScreen.main.bounds.width * 2))
        .cornerRadius(20)
            .shadow(color: Color(.black).opacity(0.5), radius: 20, x: 0, y: 0)
    }
}

struct PopUpNoteView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PopUpNoteView(note: Note(title: "Popup", bodyText: "body text", audioFilename: "", category: "popUp"))
            PopUpNoteView(note: Note(title: "Popup", bodyText: "body text", audioFilename: "", category: "popUp")).environment(\.colorScheme, .dark)
        }
    }
}
