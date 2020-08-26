//
//  SingleCardView.swift
//  Transcribe
//
//  Created by Matthew Martindale on 8/23/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import SwiftUI

struct SingleCardView: View {
    
    @State private var show = false
    @EnvironmentObject var noteController: NoteController
    
    var note: Note
    
    var body: some View {
        
        ZStack {
            
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    
                    .fill(LinearGradient(gradient: Gradient(colors: [Color("cardColor1"), Color("cardColor2")]), startPoint: .top, endPoint: .bottomLeading))
                    .frame(width: 150, height: 150, alignment: .center)
                    .overlay(Text(note.bodyText)
                        .font(.footnote)
                        .foregroundColor(Color(#colorLiteral(red: 0.9603804946, green: 0.9546712041, blue: 0.9647691846, alpha: 1)))
                        .padding()
                ).shadow(color: Color("cardColor1").opacity(0.5), radius: 7, x: 0, y: 2)
                    .onTapGesture {
                        print("tap")
                        self.show = false
                        self.noteController.selectedNote = self.note
                        withAnimation {
                            self.noteController.showPopUp.toggle()
                        }
                }
                GeometryReader { geometry in
                    Text(self.note.title).padding(.horizontal, 15).padding(.vertical, 7)
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: geometry.frame(in: .local).height / 6)
                            .foregroundColor(.red).opacity(0.9)).position(x: geometry.frame(in: .local).midX * 1.2, y: geometry.frame(in: .local).minY - 30)
                        .rotationEffect(Angle(degrees: self.show ? 50 : 0))
                        .animation(.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 0))
                        .onTapGesture {
                            self.show.toggle()
                    }
                }
            }
            VStack{
                HStack{
                    NavigationLink(destination: EditText(note: note).environmentObject(self.noteController)) {
                        Image(systemName: "pencil.circle")
                            .foregroundColor(Color("editButtonColor"))
                            .font(.system(size: 22, weight: .bold))
                            .padding(.top, 5)
                            .padding(.leading, 3)
                            .padding(.bottom, 15)
                            .padding(.trailing, 15)
                            .shadow(color: Color("editButtonColor").opacity(0.5), radius: 5, x: 4, y: 6)
                    }
                    Spacer()
                    NavigationLink(destination: EditText(note: note).environmentObject(self.noteController)) {
                        Image(systemName: "xmark.circle")
                            .foregroundColor((Color("deleteButtonColor")).opacity(0.7))
                            .font(.system(size: 20, weight: .bold))
                            .padding(.top, 3)
                            .padding(.leading, 15)
                            .padding(.bottom, 10)
                            .padding(.trailing, 3)
                            .shadow(color: Color.red.opacity(0.5), radius: 3, x: 0, y: 0)
                    }                }
                Spacer()
            }
            
        }
    }
}

struct SingleCardView_Previews: PreviewProvider {
    static var previews: some View {
        SingleCardView(note: Note(title: "Hello world", bodyText: "Body Text", audioFilename: "", color: .blue, category: "note"))
    }
}
