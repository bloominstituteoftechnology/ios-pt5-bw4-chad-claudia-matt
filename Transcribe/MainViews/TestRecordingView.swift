//
//  TestSpeechRecordingView.swift
//  Transcribe
//
//  Created by Chad Parker on 8/20/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import SwiftUI

struct TestRecordingView: View {

    @EnvironmentObject var audio: AudioController

    var body: some View {
        VStack {
            Text("RECORDING...")
                .bold()
                .foregroundColor(.red)
                .padding()
                .opacity(audio.isRecording ? 1 : 0)
            HStack {
                Button(action: {
                    self.audio.startRecording()
                }) {
                    Text("Start")
                }
                .padding()

                Button(action: {
                    self.audio.stopRecording()
                }) {
                    Text("Stop")
                }
                .padding()
            }
        }
    }
}

struct TestSpeechRecordingView_Previews: PreviewProvider {
    static var previews: some View {
        TestRecordingView()
            .environmentObject(AudioController())
    }
}
