//
//  RecordView.swift
//  Transcribe
//
//  Created by Chad Parker on 8/24/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import SwiftUI

struct RecordView: View {

    var note: Note
    @EnvironmentObject var noteController: NoteController
    @EnvironmentObject var audioRecorder: AudioRecorder

    var body: some View {
        VStack {
            Spacer()
            if audioRecorder.isRecording {
                Text("RECORDING...")
                    .foregroundColor(.red)
                    .bold()
                    .animation(.easeInOut(duration: 0.3))
                    .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
            }
            ZStack {
                Button(action: { // Record button
                    withAnimation {
                        self.audioRecorder.toggleRecording()
                        if !self.audioRecorder.isRecording {
                            if let recordingURL = self.audioRecorder.recordingURL {
                                self.noteController.add(
                                    recording: Recording(audioFileURL: recordingURL, duration: self.audioRecorder.duration),
                                    to: self.note
                                )
                            }
                        }
                    }
                }) {
                    ZStack {
                        Image("record")
                            .resizable()
                            .frame(width: 60, height: 60)
                        if audioRecorder.isRecording { // Black square overlay
                            Image(systemName: "square.fill")
                                .font(.system(size: 23))
                                .foregroundColor(Color(.label))
                        }
                    }
                }
                HStack {
                    if audioRecorder.isRecording {
                        Text(audioRecorder.elapsedTimeString)
                            .padding()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(note: noteWithRecordings)
            .environmentObject(AudioRecorder())
            .previewLayout(PreviewLayout.fixed(width: 414, height: 200))
    }
}
