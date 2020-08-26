//
//  RecordingView.swift
//  Transcribe
//
//  Created by Chad Parker on 8/24/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import SwiftUI

struct RecordingView: View {

    @EnvironmentObject var audioRecorder: AudioRecorder

    var body: some View {
        VStack {
            #warning("working on this")
            if audioRecorder.isRecording {
                Text("Recording...")
            }
            Button(action: {
                self.audioRecorder.toggleRecording()
            }) {
                Image("record")
                    .resizable()
                    .frame(width: 60, height: 60)
            }
        }
        .frame(width: 360)
        .frame(minHeight: 100)
        .border(Color.black)
    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingView()
            .environmentObject(AudioRecorder())
            //.previewLayout(PreviewLayout.fixed(width: 320, height: 120))
    }
}
