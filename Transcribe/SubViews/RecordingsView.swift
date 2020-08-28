//
//  RecordingsView.swift
//  Transcribe
//
//  Created by Chad Parker on 8/27/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import SwiftUI

struct RecordingsView: View {

    let note: Note

    var body: some View {
        List {
            ForEach(note.recordings) { recording in
                Button(action: {
                    print("play")
                }) {
                    HStack {
                        Image(systemName: "play.circle")
                        Text(recording.textTranscript)
                        Text(AudioPlayer.durationString(from: recording.duration))
                            .padding(.leading)
                    }
                }
            }
        }
    }
}

struct RecordingsView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingsView(note: noteWithRecordings)
            .previewLayout(.fixed(width: 414, height: 400))
    }
}
