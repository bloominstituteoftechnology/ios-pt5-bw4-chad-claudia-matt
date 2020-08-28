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
                SingleRecordingView(recording: recording)
            }
        }
    }
}

struct SingleRecordingView: View {

    let recording: Recording

    @EnvironmentObject var audioPlayer: AudioPlayer
    @State private var isPlaying: Bool = false

    var body: some View {
        Button(action: {
            self.isPlaying.toggle()
            self.audioPlayer.loadAudio(url: self.recording.audioFileURL)
        }) {
            HStack {
                Image(systemName: isPlaying ? "pause.circle" : "play.circle")
                Text(recording.textTranscript)
                Text(AudioPlayer.durationString(from: recording.duration))
                    .padding(.leading)
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
