//
//  RecordingsView.swift
//  Transcribe
//
//  Created by Chad Parker on 8/27/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import SwiftUI

struct RecordingsView: View {

    @Binding var note: Note

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

    var body: some View {
        Button(action: {
            if self.audioPlayer.isPlaying {
                self.audioPlayer.pause()
            } else {
                self.audioPlayer.loadAudio(url: self.recording.audioFileURL)
                self.audioPlayer.play()
            }
        }) {
            HStack {
                Image(systemName: audioPlayer.isPlaying ? "pause.circle" : "play.circle")
                Text(recording.textTranscript ?? "")
                Text(audioPlayer.isPlaying ?
                    audioPlayer.elapsedTimeString :
                    audioPlayer.durationString(from: recording.duration))
                    .padding(.leading)
            }
        }
    }
}

struct RecordingsView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingsView(note: .constant(noteWithRecordings))
            .previewLayout(.fixed(width: 414, height: 400))
    }
}
