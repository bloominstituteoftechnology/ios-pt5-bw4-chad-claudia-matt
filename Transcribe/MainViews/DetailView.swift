//
//  DetailView.swift
//  Transcribe
//
//  Created by Claudia Maciel on 8/19/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        VStack {
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
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                    .padding()
                HStack {
                    Button(action: {
                        // Edit Text
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.headline)
                            .padding(10)
                            .background(Color.black)
                            .font(.caption)
                            .foregroundColor(.white)
                            .offset(x: -5, y: 5)
                    }
    
                    Button(action: {
                        // Edit Text
                    }) {
                        Image(systemName: "pencil")
                            .font(.headline)
                            .padding(10)
                            .background(Color.black)
                            .font(.caption)
                            .foregroundColor(.white)
                            .offset(x: -5, y: 5)
                    }
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
        .navigationBarTitle(Text("Title"), displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
